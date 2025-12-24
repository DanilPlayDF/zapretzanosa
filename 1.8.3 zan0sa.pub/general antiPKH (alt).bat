@echo off
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
call service.bat status_zapret
call service.bat check_updates
call service.bat load_game_filter
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443,%GameFilter% --wf-udp=443,50000-50100,%GameFilter% ^
--filter-udp=0-65535 --filter-l7=stun --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-stun="%BIN%stun.bin" --new ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-repeats=7 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-any-protocol --dpi-desync-cutoff=d3 --dpi-desync-repeats=6 --new ^
--filter-tcp=80 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=3 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-cf.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=3 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=3 --dpi-desync-repeats=7 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-udp=443 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443,%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake,multidisorder --dpi-desync-split-pos=midsld --dpi-desync-repeats=6 --dpi-desync-fooling=md5sig,badseq --new ^
--filter-udp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=10 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=fake,split2 --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --dpi-desync-fake-http="%BIN%http_iana_org.bin" --new ^
--filter-tcp=443 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=fake,split --dpi-desync-autottl=2 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=8095 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=syndata --dpi-desync-autottl=4 --new ^
--filter-tcp=9000 --ipset="%LISTS%ipset-ea.txt" --dpi-desync=syndata --dpi-desync-autottl=4 --new ^
--filter-tcp=443 --ipset="%LISTS%ipset-cf.txt" --dpi-desync=fake,split --dpi-desync-autottl=3 --dpi-desync-repeats=7 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=2099 --ipset="%LISTS%ipset-cf.txt" --dpi-desync=syndata --dpi-desync-autottl=4 --new ^
--filter-tcp=8080 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=4 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=8443 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,split --dpi-desync-autottl=4 --dpi-desync-repeats=7 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=5222 --hostlist="%LISTS%list-general.txt" --dpi-desync=syndata --dpi-desync-autottl=4 --new ^
--filter-udp=53 --hostlist="%LISTS%list-general.txt" --dpi-desync=fake --dpi-desync-repeats=5 