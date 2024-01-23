#./biblia.sh -v 3 -c 6 -l Isaías | jq .texto | xargs | espeak --stdin -p 30 -s 180 -v mb-br1 -a 50 -g -20

anjos:
	#while true; do ./biblia.sh -v 3 -c 6 -l Isaías | jq .texto | xargs | espeak --stdin -p 30 -s 180 -v mb-br1 -a 50 -g -20; done
	
	while true; do echo "Santo, santo, santo é o Senhor Deus do universo! A terra inteira proclama a sua glória!" | espeak --stdin -p 30 -s 180 -v mb-br1 -a 50 ; done
	
