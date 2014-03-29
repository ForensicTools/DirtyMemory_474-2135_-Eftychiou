#!/usr/bin/perl
use strict;
use warnings;

my $level= 1;
my $choice= '';
my $memory= '';
my $tool= '';


while($level==1){ #Start level
	Start();

	if($choice == 1){
		ProcessMemory();
	}
	elsif($choice  == 2){
		Settings();
	}
	elsif($choice  == 3){
		exit();
	}
}

while($level==2){ #Settings level
	Settings();

	if($choice == 1){
		#PrintDatabase();
	}
	elsif($choice  == 2){
		#UpdateDatabase();
	}
	elsif($choice  == 3){
		#SearchDatabase();
	}
	elsif($choice  == 4){
		Start();
	}
}
sub ExecutePS {

    my @split_line=();

     print "Please be patient, this may take a few minutes. \n";
    open(PS, "strings $memory | grep 'bank' |") or die("Sorry! We were not able to analyse $memory \n");

    foreach my $line (<PS>) {

	print "$line\n";
    }
    close(PS);
    print "Memory analysis completed succesfully.\n";

}


sub Start {

    $level=1;
	
    print "\n";
    print "Please select your choice by number (1-3).\n";
    print "1. Process Memory\n";
    print "2. Settings\n";
    print "3. Quit\n";
    print "\n";		
    print "Choice>";
    chomp($choice = <STDIN>);

}


sub ProcessMemory {

   print "Enter a memory image you wish to analyse: ";
   chomp($memory = <STDIN>);	
	
   ExecutePS();
} 


sub Settings {

    $level=2;

    print "\n";
    print "Please select your choice by number (1-4).\n";	
    print "1. Print Dirty Database\n";
    print "2. Update Dirty Database\n";
    print "3. Search Dirty Database\n";
    print "4. Back to Start\n";
    print "\n";		
    print "Choice>";
    chomp($choice = <STDIN>);
} 

