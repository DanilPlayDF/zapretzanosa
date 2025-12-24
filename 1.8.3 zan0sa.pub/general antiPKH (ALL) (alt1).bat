@echo off
setlocal EnableDelayedExpansion
chcp 65001 > nul
:: 65001 - UTF-8

cd /d "%~dp0"
call service.bat status_zapret
echo:

call "%~dp0combine.bat" "%~dp0lists\custom\" "%~dp0lists\ipset-zapret.txt" "%~dp0lists\list-zapret.txt"
set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443,1024-65535,6695-6710 --wf-udp=443,19294-19344,50000-50100,1024-65535 ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new ^
--filter-tcp=443 --filter-l7=tls --ipset-ip=162.159.36.1,162.159.46.1,2606:4700:4700::1111,2606:4700:4700::1001 --dpi-desync=fake,fakedsplit --dpi-desync-autottl=5 --dpi-desync-repeats=6 --dpi-desync-fooling=badseq --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=multisplit --dpi-desync-split-pos=2,sniext+1 --dpi-desync-split-seqovl=679 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=80 --hostlist-exclude="%LISTS%zapret-hosts-exclude.txt" --hostlist="%LISTS%list-zapret.txt" --hostlist-auto="%LISTS%zapret-hosts-auto.txt" --hostlist="%LISTS%list-general.txt" --dpi-desync=fake,multisplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --hostlist-exclude="%LISTS%zapret-hosts-exclude.txt" --hostlist="%LISTS%list-zapret.txt" --hostlist-auto="%LISTS%zapret-hosts-auto.txt" --dpi-desync=multisplit --dpi-desync-split-pos=2,sniext+1 --dpi-desync-split-seqovl=679 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-udp=443 --hostlist-exclude="%LISTS%zapret-hosts-exclude.txt" --hostlist="%LISTS%list-zapret.txt" --hostlist-auto="%LISTS%zapret-hosts-auto.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=1024-65535 --hostlist-exclude="%LISTS%zapret-hosts-exclude.txt" --hostlist="%LISTS%list-zapret.txt" --hostlist-auto="%LISTS%zapret-hosts-auto.txt" --dpi-desync=syndata --dpi-desync-fooling=badseq,hopbyhop2 --dpi-desync-fake-tls="%BIN%tls_clienthello_iana_org.bin" --dpi-desync-cutoff=n2 --new ^
--filter-udp=1024-65535 --hostlist-exclude="%LISTS%zapret-hosts-exclude.txt" --hostlist="%LISTS%list-zapret.txt" --hostlist-auto="%LISTS%zapret-hosts-auto.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=12 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n3 --new ^
--filter-udp=443 --ipset="%LISTS%ipset-zapret.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80 --ipset="%LISTS%ipset-zapret.txt" --dpi-desync=fake,multisplit --dpi-desync-autottl=2 --dpi-desync-fooling=md5sig --new ^
--filter-tcp=443 --ipset="%LISTS%ipset-zapret.txt" --dpi-desync=multisplit --dpi-desync-split-seqovl=681 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="%BIN%4pda.bin" --new ^
--filter-tcp=1024-65535 --ipset="%LISTS%ipset-zapret.txt" --dpi-desync=syndata --dpi-desync-fooling=badseq,hopbyhop2 --dpi-desync-fake-tls="%BIN%tls_clienthello_iana_org.bin" --dpi-desync-cutoff=n2 --new ^
--filter-udp=1024-65535 --ipset="%LISTS%ipset-zapret.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=12 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n3 --new ^
--filter-tcp=6695-6710 --dpi-desync=fake,multisplit --dpi-desync-repeats=8 --dpi-desync-fooling=md5sig --dpi-desync-autottl=2 --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin"