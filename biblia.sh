VERSICULO=0 
FILTRO=0
CAPITULO=0
LIVRO=""

_cooltool()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "fooOption barOption" -- $cur) )
}
complete -F _cooltool cooltool

help()
{
	echo "================================================="
	echo "Recupera partes das escrituras o que você precisa"
	echo "================================================="
	printf "\nEXEMPLO:\n\n>$ ./biblia.sh -l \"Genesis\" -c 1 -v 1\n"
	echo """
{
  \"versiculo\": 1,
  \"capitulo\": 1,
  \"livro\": \"Genesis\",
  \"texto\": \"No princípio, Deus criou os céus e a terra.\",
  \"pagina\": 1
}
	"""
}


if [ $# -eq 0 ]; then
	help;
	exit 0;
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    -v|--verisculo)
      VERSICULO="$2"
      shift 
      shift
      FILTRO=1
      ;;
    -c|--capitulo)
      CAPITULO="$2"
      shift
      shift
      FILTRO=1
      ;;
    -l|--livro)
      LIVRO=$(echo $2 | xargs)
      #echo "LIVRO = '$LIVRO'"
      FILTRO=1
      shift 
      shift 
      ;;
    -*|--*)
      echo "Argumento não reconhecido '$1'"
      exit 1
      ;;
    *)
      help
      ;;   
     esac
done


if [ $FILTRO -eq 1 ]; then

	QUERY=".caps[]"

	if [ $CAPITULO -ne 0 ]; then
		QUERY="$QUERY | select(.capitulo == $CAPITULO)";
	fi


	if [ $VERSICULO -ne 0 ]; then
		QUERY="$QUERY | select(.versiculo == $VERSICULO)";
	fi
		

	if [ -n "$LIVRO" ]; then
		QUERY="$QUERY | select(.livro | contains(\"$LIVRO\"))";
	fi

	jq "$QUERY" biblia_sagrada.json;

fi

