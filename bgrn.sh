echo " █████╗ ██╗   ██╗████████╗ ██████╗ ███╗   ███╗ █████╗ ████████╗██╗ ██████╗ ███╗   ██╗
██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗████╗ ████║██╔══██╗╚══██╔══╝██║██╔═══██╗████╗  ██║
███████║██║   ██║   ██║   ██║   ██║██╔████╔██║███████║   ██║   ██║██║   ██║██╔██╗ ██║
██╔══██║██║   ██║   ██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██║██║   ██║██║╚██╗██║
██║  ██║╚██████╔╝   ██║   ╚██████╔╝██║ ╚═╝ ██║██║  ██║   ██║   ██║╚██████╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝
                                                                                     "
read -p "Enter Your Domain:" Domain
subfinder -d $Domain > subs.txt
cat subs.txt | sort -u | tee -a new-subs.txt
cat new-subs.txt | httprobe | tee -a alive.txt
subzy -targets alive.txt -hide_fails | tee -a res-subzy.txt
cat alive.txt | waybackurls | tee -a waybackurls.txt

for arg  in {sqli,xss,ssrf} ;
do (cat waybackurls.txt | gf "${arg}" > $arg".txt") ;
done
dalfox file xss.txt --custom-payload ./mypayloads.txt > dalfox-xss.txt
nuclei -l alive.txt -t nuclei-templates -o resault.txt


