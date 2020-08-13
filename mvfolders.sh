mkdir -p train/{Positive,Negative,Neutral}
mkdir test
mv A/* H/* Sp/* Sn/* train/Negative/
mv P/* train/Positive/
mv N/* train/Neutral/
rm -r A H Sp Sn P N

mkdir "Study Results"
mv *.txt "Study Results"/