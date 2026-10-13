python3 -c 'import sys,json
s=open(sys.argv[1],"rb").read()
w="".join("TC" if (x>>j)&1 else "AG" for x in s for j in range(7,-1,-1))
n=1
for c in w.encode():n=n*257+c+1
bits=n.bit_length()
t=bytearray()
while n>1:
 n,r=divmod(n,257)
 assert 1<=r<=256
 t.append(r-1)
assert n==1
v=bytes(t[::-1]).decode("ascii")
assert len(v)%16==0 and all(v[i:i+2] in ("AG","TC") for i in range(0,len(v),2))
b="".join("1" if v[i:i+2]=="TC" else "0" for i in range(0,len(v),2))
z=bytes(int(b[i:i+8],2) for i in range(0,len(b),8))
assert z==s and v==w and 2*(w.count("G")+w.count("C"))==len(w)
print(json.dumps({"self_reconstructed":True,"gc":"1/2","source_bytes":len(s),"atgc_length":len(w),"godel_bits":bits},separators=(",",":")))' "$0"
