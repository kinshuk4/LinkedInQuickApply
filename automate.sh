#!/bin/bash
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
declare -a keyArr=("Android Developer" "Big\ Data \Developer" "Full\ Stack\ Developer" "Backend Engineer" "Java-Develper")
declare -a resArr=("/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/java/Kinshuk_Chandra_j.pdf" 
"/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/android/Kinshuk_Chandra_a.pdf" 
"/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/bigdata/Kinshuk_Chandra_b.pdf" "/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/polyglot/Kinshuk_Chandra.pdf" "/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/python/Kinshuk_Chandra_p.pdf" "/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/fullstack/Kinshuk_Chandra_f.pdf")

# associative array
# declare -a keyArr
# keyArr["Java-Developer"]="/Users/kchandra/Lyf/Syncs/GoogleDrive/student/cv/java/Kinshuk_Chandra_j.pdf"

## now loop through the above array
hash_index() {
    case $1 in
        'Java-Developer') return 0;;
        'Android-Developer') return 1;;
        'Bigdata-Developer') return 2;;        
        'Polyglot-Developer') return 3;;
        'Python-Developer') return 4;;
        'Full\ Stack\ Developer') return 5;;
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
    hash_index $lkeyword
    lresume=${resArr[$?]}
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


