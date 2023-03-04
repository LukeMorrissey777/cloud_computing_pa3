;
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	lukemorrisseycc.com. root.lukemorrisseycc.com. (
			      5		; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
;
@	IN	NS	ns.lukemorrissey.com.
@	IN	A	172.20.74.107
ns	IN	A	172.20.74.107
@	IN	A	172.20.74.132
ns	IN	A	172.20.74.132