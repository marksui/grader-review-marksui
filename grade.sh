CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Remove any existing directories
rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone "$1" /Users/mark/Downloads/list-examples-grader/grading-area
echo 'Finished cloning'

cp -r TestListExamples.java ./grading-area/
cp -r Server.java ./grading-area/
cp -r GradeServer.java ./grading-area/
cp -r student-submission/ListExamples.java ./grading-area
cp -r lib ./grading-area


cd /Users/mark/Downloads/list-examples-grader/grading-area

set -e

if [ -f ListExamples.java ]; then
    echo "File ListExamples.java exists."
else
    echo "File ListExamples.java does not exist."
fi

if grep -q "class ListExamples" ListExamples.java; then
    echo "Class ListExamples exists."
else
    echo "Class ListExamples does not exist in ListExamples.java."
fi

ls 
pwd
javac -cp $CPATH *.java

if [ $? -eq 0 ]; then
    echo "Compilation successful."
else
    echo "Compilation failed. Check the code for errors."
fi

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > output.txt
pwd
grep -c "failures" $junit
exit
# bash grade.sh https://github.com/ucsd-cse15l-f22/list-methods-lab3