#!/bin/bash
# compatitble with bash 4
source activate per3
alias quickApply2='python quickApply2.py --username $lusername --password $lpassword  --count $lcount --keywords $lkeyword --location $llocation --resume $lresume'

# llocation="United-States"
# llocation="Canada"
# llocation="United-Kingdon"
# llocation="Germany"
# llocation="Spain"
# llocation="Switzerland"
# llocation="Australia"
# llocation="New-Zealand"
# llocation="Denmark"
# llocation="Sweden"

declare -a locArr=("United-States" "Canada" "United-Kingdon" "Germany" "Spain" "France" "Switzerland" "Netherlands" "Australia" "New-Zealand" "Denmark"  "Sweden" "Norway" "Finland")


javaRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/java/Kinshuk_Chandra_j.pdf"
androidRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/android/Kinshuk_Chandra_a.pdf"
bigdataRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/bigdata/Kinshuk_Chandra_b.pdf"
polyglotRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/polyglot/Kinshuk_Chandra.pdf"
pythonRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/python/Kinshuk_Chandra_p.pdf"
fullStackRes="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/fullstack/Kinshuk_Chandra_f.pdf"

declare -a keyResMap
keyResMap["Android-Developer"]=$androidRes
keyResMap["Senior-Android-Developer"]=$androidRes
keyResMap["Big-Data-Developer"]=$bigdataRes
keyResMap["Senior-Data-Team-Lead"]=$bigdataRes
keyResMap["Apache-Spark"]=$bigdataRes
keyResMap["JPA"]=$javaRes
keyResMap["hibernate"]=$javaRes
keyResMap["spring-framework"]=$javaRes
keyResMap["Backend-Engineer"]=$javaRes
keyResMap["Java-Develper"]=$javaRes
keyResMap["Senior-Java-Develper"]=$javaRes
keyResMap["java"]=$javaRes
keyResMap["Python-Developer"]=$pythonRes
keyResMap["Full-Stack-Developer"]=$fullStackRes
echo "${!keyResMap[@]}"
# associative array
# declare -a keyArr
# keyArr["Java-Developer"]="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/java/Kinshuk_Chandra_j.pdf"

## now loop through the above array

lcount=1

for i in "${locArr[@]}"
do
   llocation="$i"
   echo $llocation
   for j in "${!keyResMap[@]}";
   do    
    lkeyword="$j"
    lresume=${keyResMap[$j]}
    echo $lkeyword $lresume
    #python quickApply2.py --username $lusername --password $lpassword  --count $lcount --keywords $lkeyword --location $llocation --resume $lresume
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


