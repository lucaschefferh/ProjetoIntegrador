extends Node

# --- DADOS DA SESSÃO ATUAL (Temporários) ---
# Estes dados mudam toda vez que alguém joga
var nome_jogador: String = ""
var idade_jogador: int = 0
var tempo_fase: float = 0.0
var tentativas: int = 0
var jogando: bool = false

# --- HISTÓRICO DE RECORDES (Permanente) ---
# Esta lista guarda TODOS os jogadores que já venceram
var historico_pontuacao: Array = [] 

# Mudamos o nome do arquivo para não confundir com o save antigo
const CAMINHO_SAVE = "user://leaderboard.json"

func _ready():
	# Assim que o jogo abre, já carrega a lista de recordes
	carregar_leaderboard()

func _process(delta):
	# Cronômetro global
	if jogando:
		tempo_fase += delta

# --- CONTROLE DA SESSÃO ---
func iniciar_nova_partida():
	tempo_fase = 0.0
	tentativas = 0
	jogando = true

func parar_cronometro():
	jogando = false

func adicionar_tentativa():
	tentativas += 1

# --- A MÁGICA: REGISTRAR VITÓRIA ---
# Essa função deve ser chamada APENAS na tela de vitória final (RF10)
func registrar_vitoria_final():
	parar_cronometro()
	
	# Cria um dicionário com os dados dessa partida
	var novo_registro = {
		"nome": nome_jogador,
		"idade": idade_jogador,
		"tempo": tempo_fase,
		"erros": tentativas,
		"data": Time.get_date_string_from_system() # Salva a data de hoje (AAAA-MM-DD)
	}
	
	# Adiciona na lista e salva no arquivo
	historico_pontuacao.append(novo_registro)
	salvar_leaderboard()
	print("Vitória registrada para: ", nome_jogador)

# --- SISTEMA DE ARQUIVOS (JSON) ---
func salvar_leaderboard():
	var arquivo = FileAccess.open(CAMINHO_SAVE, FileAccess.WRITE)
	if arquivo:
		# Transforma a LISTA inteira em texto e salva
		var texto_json = JSON.stringify(historico_pontuacao)
		arquivo.store_string(texto_json)

func carregar_leaderboard():
	if FileAccess.file_exists(CAMINHO_SAVE):
		var arquivo = FileAccess.open(CAMINHO_SAVE, FileAccess.READ)
		var texto = arquivo.get_as_text()
		
		# Tenta ler. Se o arquivo estiver corrompido ou vazio, cria lista nova.
		var dados = JSON.parse_string(texto)
		if dados is Array:
			historico_pontuacao = dados
		else:
			historico_pontuacao = []
	else:
		historico_pontuacao = [] # Começa do zero se não tiver arquivo
