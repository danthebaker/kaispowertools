Echo off
Cls
If Exist Result1.txt del Result1.txt
If Exist Result2.txt del Result2.txt
IPConfig >Result1.txt
Find /I "IPv4 Address. . . . . . . . . . . : 194.143.183." Result1.txt >Result2.txt
For /F "tokens=2 delims=:" %%A IN (Result2.txt) Do Set NewIP=%%A

Rem ---------
Echo %NewIP%
pause
Rem ----------

Rem Delete existing routes if any exist
route delete 10.1.1.0
route delete 10.1.5.0
route delete 213.165.90.181
route delete 82.165.29.155
route delete 82.165.139.206
route delete 82.165.27.156
route delete 195.214.216.40
route delete 195.214.216.43
route delete 195.214.216.53
route delete 195.214.216.54
route delete 195.214.216.85
route delete 195.214.216.159
route delete 195.214.219.235
route delete 10.11.0.0
route delete 10.100.5.0

rem xoc-2 machines & internal Xara servers
route add 10.1.1.0 mask 255.255.255.0 %NewIP%
route add 10.1.5.0 mask 255.255.255.0 %NewIP%
route add 10.1.5.0 mask 255.255.255.0 %NewIP%

rem Downloads 2,3,4,5 (Xara External servers rented from 1&1)
route add 82.165.29.155 mask 255.255.255.255 %NewIP%
route add 213.165.90.181 mask 255.255.255.255 %NewIP%
route add 82.165.139.206 mask 255.255.255.255 %NewIP%
route add 82.165.27.156 mask 255.255.255.255 %NewIP%

rem Magix Servers
route add 195.214.216.40 mask 255.255.255.255 %NewIP%
route add 195.214.216.43 mask 255.255.255.255 %NewIP%
rem Magix DNS servers (53 & 54)
route add 195.214.216.53 mask 255.255.255.255 %NewIP%
route add 195.214.216.54 mask 255.255.255.255 %NewIP%
route add 195.214.216.85 mask 255.255.255.255 %NewIP%
route add 195.214.216.159 mask 255.255.255.255 %NewIP%
route add 195.214.219.209 mask 255.255.255.255 %NewIP%

rem Magix Author IT database
route add 195.214.219.235 mask 255.255.255.255 %NewIP%
rem Magix MIS
route add 10.11.0.0 mask 255.255.0.0 %NewIP%
rem Magix Usertool
route add 10.100.5.0 mask 255.255.255.0 %NewIP%

Del Result1.txt
Del Result2.txt
Set NewIP=Nul