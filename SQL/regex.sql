# 1 - Remove acentuação em uma string
regexp_replace(normalize(text, NFD), r"\pM", '')

# - Procura Palavra2 desde que ela não seja precedida da Palavra1 (não precisa ser imediatamente anterior)
r"^(?:(?!\bPalavra1\b).)*\bPalavra2\b"
