# Combinar 2 dataframes e excluir as linhas comuns
df_all = df1.merge(df2.drop_duplicates(), on=['col1','col2'], how='left', indicator=True)

df_distinct = df_all[~(df_all['_merge'] == 'both')]

