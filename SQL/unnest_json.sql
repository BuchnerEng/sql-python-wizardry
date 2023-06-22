CREATE TEMP FUNCTION jsonParsed(input STRING)
RETURNS Array<Struct<key STRING, type STRING>>
DETERMINISTIC LANGUAGE js AS 
"""
function processKey(node, parent) {
    var ary = [];
    if (parent !== '') {
        parent += '.';
    }
    if (node == null) {
        ary.push({
            key: parent,
            type: 'null'
        })
    } else {
        Object.keys(node).map(function(key) {
            var v = node[key];
            if (node.constructor.name == "Array") {
                keytouse = '[]'
            } else {
                keytouse = key
            }
            if ((v == null) || (typeof(v) !== 'object')) {
                if (v == null) { typetouse = 'null';} else {typetouse = typeof(v);}
                ary.push({
                    key: parent + keytouse,
                    type: typetouse
                });
            } else {
                ary.push({
                    key: parent + keytouse,
                    type: v.constructor.name
                });
                ary = [].concat(ary, processKey(v, parent + keytouse));
            }
        });
    }
    return ary;
}
return processKey(JSON.parse(input), '');
""";

with keys as (SELECT jsonParsed(your-json-field) as keys  FROM `your-project-id.your-database-id.your-table-id`)
select key, type, count(*) as n from keys k cross join unnest(k.keys) as kk group by key, type order by key asc;
