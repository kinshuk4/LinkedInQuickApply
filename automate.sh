#!/bin/bash
source activate per3
alias quickApply2='python quickApply2.py --username $lusername --password $lpassword  --count $lcount --keywords $lkeyword --location $llocation --resume $lresume'


declare -a locArr=("United-States" "Canada" "United-Kingdon" "Germany" "Spain" "France" "Switzerland" "Netherlands" "Australia" "New-Zealand" "Denmark"  "Sweden" "Norway" "Finland")

javaRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/java/Kinshuk_Chandra_j.pdf"
androidRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/android/Kinshuk_Chandra_a.pdf"
bigdataRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/bigdata/Kinshuk_Chandra_b.pdf"
polyglotRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/polyglot/Kinshuk_Chandra.pdf"
pythonRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/python/Kinshuk_Chandra_p.pdf"
fullStackRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/fullstack/Kinshuk_Chandra_f.pdf"

keyAD='Android-Developer'
#keySAD='Senior-Android-Developer'
keyBD='Bigdata-Developer' 
keySDTL='Senior-Data-Team-Lead'
keySpark='Apache-Spark'
keyHibernate='hibernate'
keyJpa='JPA'
keySpring='Spring-Framework'
keyJD='Java-Develper'
keySJD='Senior-Java-Develper'
keyJava='java'
keyPD='Python-Developer'
keyPolyD='Polyglot-Developer'
keyFSD='Full-Stack-Developer'

declare -a keyArr=($keyAD $keyBD $keySDTL $keySpark $keyHibernate $keyJpa $keySpring $keyJD $keySJD $keyJava $keyPD $keyPolyD $keyFSD)

hash_index() {
    case $1 in
        $keyAD) echo $androidRes;;
        $keySAD) echo $androidRes;;
        $keyBD) echo $bigdataRes;;        
        $keySpark) echo $bigdataRes;;
        $keyHibernate) echo $javaRes;;
        $keyJpa) echo $javaRes;;
        $keySpring) echo $javaRes;;
        $keyJD) echo $javaRes;;
        $keySJD) echo $javaRes;;
        $keyJava) echo $javaRes;;
        $keyPD) echo $pythonRes;;
        $keyPolyD) echo $polyglotRes;;
        $keyFSD) echo $fullstack;;
    esac
}
lcount=1

for i in "${locArr[@]}"
do
   llocation="$i"
   echo $llocation
   for key in "${keyArr[@]}";
   do    
    lkeyword="$key"
    lresume=$(hash_index $lkeyword)
    echo $lkeyword $lresume
    python quickApply2.py --username $lusername --password $lpassword  --count $lcount --keywords $lkeyword --location $llocation --resume $lresume
   done
   sleep 5
   # or do whatever with individual element of the array
done

# lcount=1

# lkeyword="Java Developer"
# lresume="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/java/Kinshuk_Chandra_j.pdf"


# lkeyword="Android-Developer"
# lresume="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/android/Kinshuk_Chandra_a.pdf"


# /Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/bigdata/Kinshuk_Chandra_b.pdf
# /Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/fullstack/Kinshuk_Chandra_f.pdf
# /Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/java/Kinshuk_Chandra_j.pdf
# /Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/polyglot/Kinshuk_Chandra.pdf
# /Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/python/Kinshuk_Chandra_p.pdf


