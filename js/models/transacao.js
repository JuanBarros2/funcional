class Transacao {
	//data em que a transacao aconteceu
private GregorianCalendar data;

//texto identificador da transacao (definida pelo banco)
	private String textoIdentificador;

	//valor da transacao
	private double valor;

	//descricao (infos extras) da transacao
	private String descricao;

	//numero do DOC (toda transacao tem um)
	private String numeroDOC;

	private boolean classificada; //DESCONSIDERAR
	
//os tipos que essa transacao tem
//TipoTransacao é um enum que assume valores que são Strings
private LinkedList<TipoTransacao> tipos;

	private LinkedList<DescricaoArquivo> arquivos; //DESCONSIDERAR
}
