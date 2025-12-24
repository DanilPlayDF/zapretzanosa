@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
call service.bat status_zapret
call service.bat load_game_filter
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443,1024-65535,8095,9000,2099,8080,8443,5222 --wf-udp=1024-65535,443,50000-50100,53,64090-64110 ^
--filter-udp=0-65535 --filter-l7=stun --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-stun="%BIN%stun.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-repeats=7 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=3 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=3 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=3 --dpi-desync-repeats=7 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-udp=443 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443,%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=6 --dpi-desync-fooling=md5sig,badseq --new ^
--filter-udp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=10 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=fake,split --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=md5sig,badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=443 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=8 --dpi-desync-fooling=md5sig,badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_iana_org.bin" --new ^
--filter-tcp=8095 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=syndata --dpi-desync-autottl=2 --dpi-desync-repeats=6 --new ^
--filter-tcp=9000 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=syndata --dpi-desync-autottl=2 --dpi-desync-repeats=6 --new ^
--filter-udp=0-65535 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=fake,split --dpi-desync-fooling=badseq --dpi-desync-any-protocol=1 --dpi-desync-cutoff=n3 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=8 --dpi-desync-fooling=md5sig,badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_iana_org.bin" --new ^
--filter-udp=443 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=2099 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=syndata --dpi-desync-autottl=4 --new ^
--filter-tcp=8080 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=4 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=8443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=4 --dpi-desync-repeats=7 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=5222 --hostlist="%LISTS%list-general.txt" --dpi-desync=syndata --dpi-desync-autottl=4 --new ^
--filter-udp=53 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-repeats=5 --new ^
--filter-tcp=1119 --ipset="%LISTS%ipset-battlenet.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls-mod=rnd,rndsni,padencap --new ^
--filter-udp=443 --ipset="%LISTS%ipset-amazonaws.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=443 --ipset="%LISTS%ipset-amazonaws.txt" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=8 --dpi-desync-fooling=md5sig,badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_iana_org.bin" --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-amazonaws.txt" --dpi-desync=fake,multisplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-fake-http="%BIN%http_iana_org.bin" --new ^
--filter-tcp=1024-65535 --ipset="%LISTS%ipset-amazonaws.txt" --dpi-desync=syndata --dpi-desync-fooling=badseq,hopbyhop2 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --new ^
--filter-udp=1024-65535 --ipset="%LISTS%ipset-amazonaws.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=10 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --new ^
--filter-udp=64090-64110 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=2099,5222-5223,8000-8020,8393-8400 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-fake-http="%BIN%http_iana_org.bin" --new ^
--filter-tcp=6695-6705 --ipset="%LISTS%ipset-cloudflare.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fooling=badseq
