if [ $# -lt 2 ]
then
	echo "Usage: gen_cert.sh <name> <extension>"
	exit 1
fi

CERT_PATH="/opt/secpi/certs"

# generate key
openssl genrsa -out $CERT_PATH/$1.key.pem 2048
# generate csr
openssl req -config $CERT_PATH/ca/openssl.cnf -new -key $CERT_PATH/$1.key.pem -out $CERT_PATH/$1.req.pem -outform PEM -subj /CN=$1/ -nodes
# sign cert
openssl ca -config $CERT_PATH/ca/openssl.cnf -in $CERT_PATH/$1.req.pem -out $CERT_PATH/$1.cert.pem -notext -batch -extensions $2