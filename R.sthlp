{smcl}
{right:version 1.1.5}
{title:Title}

{phang}
{cmd:{opt R:call}} {hline 2} seamless interactive {bf: {browse "https://cran.r-project.org/":R}} in Stata. The package automatically returns {help return:rclass} R objects with 
 {it:numeric}, {it:integer}, {it:character}, {it:logical}, {it:matrix}, {it:data.frame}, {it:list}, and {it:NULL} 
 classes in Stata. It also allows passing Stata {bf:variables}, {bf:data set}, 
 {help macro}, {help scalar}, and {help matrix} to R as well as load data from R 
 to Stata automatically, 
 which provides an automated reciprocal communication between Stata and R. 
 For more information visit  {browse "http://www.haghish.com/packages/Rcall.php":Rcall homepage}.
 

{title:Syntax}

{p 4 4 2}
In general, the syntax of the {opt R:call} package can be abbreviated as 
follows:

{p 8 16 2}
{opt R:call} [{it:mode}] [{cmd::}] [{it:command}]
{p_end}


{p 4 4 2}
The {opt R:call} package was designed to be interactive. However, additional {it:modes} were 
designed to enhance the functionality of the package for embedding R script 
in {it:ado} programs or using it for {it:exploratory analysis}. 
The table below summarizes the {it:mode} subcommand

{* the new Stata help format of putting detail before generality}{...}
{synoptset 22 tabbed}{...}
{synopthdr:Mode}
{synoptline}
{synopt:{opt vanilla}}Calls R non-interactively. This mode is advised for programmers 
who wish to embed R in theis Stata packages{p_end}

{synopt:{opt sync}}synchronizes {it:data}, {it:matrices}, and {it:scalars} between 
R and Stata. Making a change in any of these objects in either Stata or 
R will change the object in the other environment. Programmers are 
advised not to use this mode in ado programs. {p_end}

{synopt:{opt setpath}}permanently defines the path to executable 
R on the machine, which can be given as a string{p_end}
{synoptline}
{p2colreset}{...}


{p 4 4 2}
The colon sign [{cmd::}] is optional, only meant to separate the Stata command 
from R command. The [{it:mode}] is subcommand changes the behavior of {opt R:call} 
and can be {bf:setpath}, {bf:vanilla}, and {bf:sync}. In addition to these modes, 
{opt R:call} also includes an {it:R console mode} which can be evoked by 
executing {opt R:call} without any R command. 
{help Rcall##running_R:Read more about console mode...}

{p 8 16 2}
{opt R:call} [{cmd:sync}] [{cmd::}]
{p_end}


{p 4 4 2}
In contrast, executing {opt R:call} with an R command will avoid entering 
the {it:R console mode}. The {bf:vanilla} subcommand executes R non-interactively, but still 
communicates data from R to Stata after execution. The {bf:sync} mode synchronizes 
Stata and R objects which includes {bf:data sets}, {bf:matrices}, and {bf:scalars}. 
Read more about {help Rcall##synchronize:sync} mode. 

{p 8 16 2}
{opt R:call} [{cmd:vanilla}] [{cmd::}] [{it:command}]
{p_end}


{p 4 4 2}
permanently setup the path to executable R on the machine, if different with the 
default paths ({help Rcall##Rpath:see below}).

{p 8 16 2}
{opt R:call} {cmd:setpath}  {it:"path/to/R"}
{p_end}


{title:Description}

{p 4 4 2}
{bf: {browse "https://cran.r-project.org/":R statistical language}} is a free software 
and programming langage for statistical computing and graphics. 
The {opt R:call} package combines the power of R with Stata, allowing the 
Stata users to call R interactively within Stata and communicate 
data and analysis results between R and Stata simultaniously. 

{p 4 4 2}
In other words, anytime an R code is executed, the R objects are available 
for further manipulation in Stata. 
R objects with 
{it:numeric}, {it:integer}, {it:character}, {it:logical}, {it:matrix}, {it:list}, and {it:NULL} 
classes are automatically returned to Stata as {help return:rclass}. 

{p 4 4 2}
R objects with {it:data.frame} class can be automatically loaded from R to 
Stata using the {bf:load.data()} function (see below).


{title:Communication from R to Stata}

{p 4 4 2}
Stata automatically receives R objects as {help return:rclass} anytime 
the {opt R:call} is executed. If R is running interactively 
(i.e. without {bf:vanilla} subcommand), the previous objects still remain accessable 
to Stata, unless they are changed or erased from R. Moreover, the packages 
that you load from Stata in R remain loaded until you detach them. 

{p 4 4 2}
Accessing R objects in Stata is simultanious which makes working with 
{opt R:call} convenient. For example a {it:numeric}, or {it:string} vector which is 
defined in R, can be accessed in Stata as simple as calling the name of that 
object withing {help rclass} i.e. {bf:r({it:objectname})}.    {break}

{p 4 4 2}
A {it:numeric} object example:

        . R: a <- 100 
        . display r(a)  	
        100 	
		
{p 4 4 2}
Without the {bf:vanilla} subcommand, the defined object remains in the memory of 
R and consequently, returned to Stata anytime R is called.

        . R: a 
        [1] 100 
		
{p 4 4 2}
A {it:string} object example:
		
        . R: str <- "Hello World" 
        . display r(str)  	
        Hello World
		
        . R: str <- c("Hello", "World") 
        . display r(str)  	
        "Hello"  "World"
		
{p 4 4 2}
A {it:vector} example:

        . R: v <- c(1,2,3,4,5)
        . display r(v)  	
        1 2 3 4 5

{p 4 4 2}
A {it:matrix} example:

        . R: A = matrix(1:6, nrow=2, byrow = TRUE) 
        . mat list r(A) 
        r(A)[2,3]
            c1  c2  c3  	
        r1   1   2   3
        r2   4   5   6
		
{p 4 4 2}
A {it:list} example:

        . R: mylist <- list(a=c(1:10))
        . display r(mylist_a) 
        1 2 3 4 5 6 7 8 9 10

{p 4 4 2}
A {it:logical} example:

        . R: l <- T 
        . display r(l)
        TRUE
		
{p 4 4 2}
A {it:NULL} example:

        . R: n <- NULL
        . display r(n)
        NULL	
		
{p 4 4 2}
Regarding communicating R data set to Stata automatically, see the 
{bf:load.data({it:dataframe})} function below. 
		

{title:Communication from Stata to R}

{p 4 4 2}
The table below shows the of the functions needed for data communication from 
Stata to R. 

{* the new Stata help format of putting detail before generality}{...}
{synoptset 22 tabbed}{...}
{synopthdr:Function}
{synoptline}
{synopt:{opt st.scalar()}}passes a scalar to R{p_end}
{synopt:{opt st.matrix()}}passes a matrix to R{p_end}
{synopt:{opt st.var(varname)}}passes a numeric or string variable to R{p_end}
{synopt:{opt st.data(filename)}}passes data from Stata to R{p_end}
{synopt:{opt load.data(dataframe)}}loads data from R dataframe to Stata{p_end}
{synoptline}
{p2colreset}{...}

{p 4 4 2}
For an ideal reciprocation between Stata and R, Stata should also easily 
communicate variables to R. Local and global {help macro:macros} can be passed 
within R code, since Stata automatically interprets them while it passes the 
code to {opt R:call} command, as shown in the example below:

        . global a 99 
        . R: (a <- $a)  	
        [1] 99 		

{p 4 4 2}
In order to pass a {help scalar} from Stata to R, you can 
use the {bf:st.scalar()} function as shown below:

        . scalar a = 50 
        . R: (a <- st.scalar(a))  	
        [1] 50 		

{p 4 4 2}
Similarly, Stata {help matrix:matrices} can be seamlessly passed to R using 
the {bf:st.matrix()} function as shown below:

        . matrix A = (1,2\3,4) 
        . matrix B = (96,96\96,96) 		
        . R: C <- st.matrix(A) + st.matrix(B)
        . R: C 
             [,1] [,2]
        [1,]   97   98
        [2,]   99  100

{p 4 4 2}
And of course, you can access the matrix from R in Stata as well: 

        . mat list r(C) 
        r(C)[2,2]
             c1   c2
        r1   97   98
        r2   99  100

{p 4 4 2}
Passing variables from Stata to R is convenient, using the    {break}
{bf:st.var({it:varname})} function. Therefore, any analysis can be executed in R 
simply by passing the variables required for the analysis from Stata to R:

        . sysuse auto, clear 
        . R: dep <- st.var(price)		
        . R: pre <- st.var(mpg)	
        . R: lm(dep~pre)

        Call:
        lm(formula = dep ~ pre)

        Coefficients:
        (Intercept)          pre  
            11267.3       -238.3

{p 4 4 2}
The {opt R:call} package also allows to pass Stata data to R within 
{bf:st.data({it:{help filename}})} function. This function relies on the {bf:foreign} 
package in R to load Stata data sets, without converting them to CSV or alike. 
The {bf:foreign} package can be installed within Stata as follows:

        . R: install.packages("foreign", repos="http://cran.uk.r-project.org")

{p 4 4 2}
Specify the relative or absolute path to the data set to transporting data 
from Stata to R. For example: 

        . R: data <- st.data(/Applications/Stata/ado/base/a/auto.dta) 
        . R: dim(data)

{p 4 4 2}
If the {it:filename} is not specified, the function passes the currently loaded 
data to R. 

        . sysuse auto, clear 
        . R: data <- st.data() 
        . R: dim(data) 
        [1] 74 12
		
{p 4 4 2}
Finally, the data can be imported from R to Stata automatically, using the 		
{bf:load.data({it:dataframe})} function. This function will automatically save a 
Stata data set from R and load it in Stata by clearing the current data set, 
if there is any. Naturally, you can have more control over converting variable 
types if you write a proper code in R for exporting Stata data sets. Nevertheless, 
the function should work just fine in most occasions: 

        . clear 
        . R: mydata <- data.frame(cars) 
        . R: load.data(mydata) 
        . list in 1/2
        {c TLC}{hline 14}{c TRC}
        {c |} speed   dist {c |}
        {c LT}{hline 14}{c RT}
     1. {c |}     4      2 {c |}
     2. {c |}     4     10 {c |}
        {c BLC}{hline 14}{c BRC}

{marker running_R}{...}

{title:Running R environment}

{p 4 4 2}
To enter the R environment within Stata, 
type {opt R:call}. This runs R in Stata 
interactively similar to running {help mata} environment. However, with 
every R command you execute, Stata obtains the objects from R 
simultaniously. Note that similar to mata environment, you cannot 
execute R commands from the Do-File Editor when the environment is 
running. To execute R from Do-File Editor, you should call R using the 
{opt R:call} command. Nevertheless, the 
{bf:st.scalar()}, {bf:st.matrix()}, {bf:st.data()}, and {bf:load.data()} functions 
will continue to work when R environment is running. 

        . scalar a = 999
        . R:
	{hline 49} R (type {cmd:end} to exit) {hline}
        . a <- 2*(st.scalar(a))
        . a
        [1] 1998
        . end
	{hline}
		
        . display r(a)
        1998
		
		
{p 4 4 2}
The interactive mode also supports multi-line code. The {bf:+} sign is added 
automatically:

        . R:
	{hline 49} R (type {cmd:end} to exit) {hline}
        . myfunction <- function(x) {
        +
        . if (is.numeric(x)) {
            +
        .   return(x^2)
            +
        . }
        +
        . }
        . (a <- myfunction(199))
        . [1] 39601
        . end
	{hline}
		
        . display r(a)
        39601
		
{marker Rpath}{...}

{title:R path setup}

{p 4 4 2}
The package requires  {browse "https://cran.r-project.org/":R} to be installed on the machine. 
The package detects R in the default paths based on the operating system. 
The easiest way to see if R is accessible is to execute a command in R 

        . R: print("Hello World") 
        [1] "Hello World" 

{p 4 4 2}
If R is not accessible, you can also permanently 
setup the path to R using the {bf:setpath} subcommand. For example, the 
path to R on Mac 10.10 could be:

    . {cmd:R setpath} "{it:/usr/bin/r}"

{marker synchronize}{...}

{title:sync mode}

{p 4 4 2}
By default, {opt R:call} returns {it:rclass} objects from R to Stata and allows passing 
Stata objects to R using several functions. However, the package also has a 
{bf:sync} mode where it {bf:automatically synchronizes the global environments 
of Stata and R, allowing real-time synchronization between the two languages, 
which consequently {bf:replaces} the objects whenever they change in either of 
the environments. This mode is by default is {bf:off}. 

{p 4 4 2}
The {bf:sync} mode allows maximum interactive experience for {it:numeric} and 
{it:string} scalars and {it:matrices} in Stata. The mode 
{ul:does not synchronize global macros}. See the examples below to see 
how a scalar or matrix change when the synchronization mode is {bf:on}. 

{p 4 4 2}
In the example below, the value of {bf:a} changes from {bf:1} to {bf:0} after it 
is altered in R:

        . scalar a = 1
        . R sync: (a = 0)
        [1] 0
        . display a
        0

{p 4 4 2}
The same example is repeated {bf:without} sync mode:
		
        . scalar a = 1
        . R: (a = 0)
        [1] 0
        . display a
        1
		
{p 4 4 2}
The synchronize mode also replaces matrices in R and Stata, when there is a 
change in the matric in either of the environments. Naturally, new 
matrices also are synchronized:

        . mat drop _all
        . mat define A = (1,2,3 \ 4,5,6)
        . Rcall sync: B = A
        . mat list B

        B[2,3]
            c1  c2  c3 
        r1   1   2   3
        r2   4   5   6 

{p 4 4 2}
		. mat C = B/2
        . R sync: C
             [,1] [,2] [,3] 
        [1,]  0.5  1.0  1.5 
        [2,]  2.0  2.5  3.0 
		
{p 4 4 2}
As shown in the examples, any change made to the matrices, whether it has 
happened in R or Stata will be instantly available in the other environment. 
While such a level of integration between the two languages is {bf:exciting}, 
it requires a lot of caution and testing. This is rather an exploratory 
feature which is not a main-stream approach to calling a foreign language 
in a programming language. 
{bf:If you have suggestions or concerns in this regard, feel free to reach out to me for a discussion}.    {break}
	

{title:Remarks}

{p 4 4 2}
You should be careful with using Stata symbols in R. For example, the {bf:$} 
sign in Stata is preserved for global macros. To use this sign in R, you 
should place a backslash before it to pass it to R. For example:

        . R: head(cars\$speed)

{p 4 4 2}
Also, the object name in R can include a dot, for example:

        . R: a.name <- "anything" 
		
{p 4 4 2}
The {opt R:call} package returns scalars and locals which can only include 
underscore in the names (e.g. a_name). {opt R:call} automatically converts 
dots to underscore in the name. In the example above, if you type {cmd:return list} 
in Stata, you would get a macro as follos:

        . return list 
        r(a_name) : "anything"
		
{p 4 4 2}
To maximize the speed of calling R from Stata, 
detach the packages that are no longer needed and also, drop all the objects 
that are of no use for you. The more objects you keep in R memory, 
the more time needed to automatically communicate those objects between 
R and Stata.		


{title:Erasing R memory and detaching objects}

{p 4 4 2}
When you work with {bf:Rcall} interactively (without {bf:vanilla} subcommand), 
anything you do in R is memorized and 
saved in a {bf:.RData} file automatically, even if you quit R using {bf:q()} 
function. If you wish to clear the memory and erase everything defined in R, 
you should {bf:unlink} the {bf:.RData} file and erase the objects:

        . R: unlink(".RData") 	
        . R: rm(list=ls())
		
{p 4 4 2}
However, the commands above do not erase the {bf:attached} packages and data sets. 
you can view the attached objects in your R environment using the {bf:search()} 
function. To detach packages or objects, use the {bf:detach()} function. Note that 
packages are named as {bf:"package:_name_"}. Here is an example of detaching a 
data set and a package 

        . R:
	{hline 49} R (type {cmd:end} to exit) {hline}
        . attach(cars)
        . library(Rcpp)               # make sure you have it installed
        . search()                    # Output is omitted ...
        .
        . detach(cars)
        . detach("package:Rcpp")
	{hline}

{p 4 4 2}
detach("package:graphics", unload=TRUE)


{title:Example(s)}

{p 4 4 2}
Visit  {browse "http://www.haghish.com/packages/Rcall.php":Rcall homepage} for more examples and 
documentation. 


{title:Author}

{p 4 4 2}
{bf:E. F. Haghish}       {break}
Center for Medical Biometry and Medical Informatics       {break}
University of Freiburg, Germany       {break}
{it:and}          {break}
Department of Mathematics and Computer Science         {break}
University of Southern Denmark       {break}
haghish@imbi.uni-freiburg.de       {break}

{p 4 4 2}
{browse "www.haghish.com/packages/Rcall.php":Rcall Homepage}           {break}
Package Updates on  {browse "http://www.twitter.com/Haghish":Twitter}       {break}

    {hline}

{p 4 4 2}
This help file was dynamically produced by {help markdoc:MarkDoc Literate Programming package}

