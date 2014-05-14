#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor;
use Smart::Comments;
	
my $choice= 0;
my $memory= '';
my $tool= '';
my %dirty_key =();
my %findings =();
my $color='red';
my $database="dirtyDatabase.txt";

    print "Loading Database..\n";
    open IN, $database or die "Cannot read: $!\n";

    while( my $line = <IN> )  {
	chomp $line;
	my @dirtykeys = split('::', $line);

	foreach my $key (@dirtykeys){
		if(length($key)!=0)
		{
			$dirty_key{$key} =1; 	
		}	
	}
	chomp $line;
    }
    close(IN);


while(1)
{
	&Start;
	

	if($choice == 1){
		&ProcessMemory;
	}
	elsif($choice  == 2){
	
		while(1)
		{
			&Settings;
	
			if($choice == 1){
			
				&PrintDatabase;
			}
			elsif($choice  == 2){
				&UpdateDatabase();
			}
			elsif($choice  == 3){
				&SearchDatabase();
			}
			elsif($choice  == 4){
				&ColorPicker	();
			}
			elsif($choice  == 5){
				last;
			}
		}
	}

	
}

sub ExecutePS {
   my $memory=shift;

    print "Please be patient, this may take a few minutes. \n";
    
    for my $key ( keys %dirty_key ) {  ### Evaluating [===|    ] % done
        open(PS, "strings $memory | grep $key |") or break("Cannot find $memory \n");
	foreach my $line (<PS>) {
		
		if(! exists($findings{$line} ) ){
			my @values = split('(\s+)',$line);
			foreach my $value (@values){
				if($value=~ /$key/)
				{
					    print color $color;
    					    print "$value";
   					    print color 'reset';
				}else{
					print "$value";
				}
			}
			$findings{$line} =1; 
		}
    	}
    }  
    close(PS);

    print "Memory analysis completed succesfully.\n";

}


sub Start {	

    print "\n";
    print "Please select your choice by number (1-2).\n";
    print "1. Process Memory\n";
    print "2. Settings\n";
    print "\n";		
    print "Choice>";
    chomp($choice = <STDIN>);

}


sub ProcessMemory {
	
	print "Enter a memory image you wish to analyse: ";
	chomp($memory = <STDIN>);	

	ExecutePS($memory);
     
} 


sub Settings {	
    print "\n";
    print "Please select your choice by number (1-4).\n";	
    print "1. Print Database\n";
    print "2. Update Database\n";
    print "3. Search Database\n";
    print "4. Chose text color\n";
    print "5. Back to Start\n";
    print "\n";		
    print "Choice>";
    chomp($choice = <STDIN>);

} 

sub PrintDatabase {
    for my $key ( keys %dirty_key ) {
        print "$key\n";
    }
} 

sub UpdateDatabase {
	my $update;
	my $key;

	print "1. Add key.\n";
	print "2. Remove key.\n";
	print "3. Back to Settings.\n";
   	print "\n";		
   	print "Choice>";
    	chomp ($update = <STDIN>);

	if($update==1){
		do{
			print "Enter a key to add>";
			chomp($key = <STDIN>); 
 		}until(length($key)!=0);
		
		if( exists($dirty_key{$key} ) ){
			print "\"$key\" already exists in database\n";
		}else{
			$dirty_key{$key} =1; 
			print "\"$key\" added to database\n";
		}
			
		
	}elsif($update==2){
	 	do {
			print "Enter a key to remove>";
			chomp($key = <STDIN>); 
 		}until(length($key)!=0);

		if( exists($dirty_key{$key} ) ){
		        delete $dirty_key{$key};
			print "\"$key\" removed from database\n";
		}else{
			print "\"$key\" does not exist in database\n";
		}
	}elsif($update==3){
		return;
	}

	open(DATA,">$database") || die("Can't update file");
 	for my $newKey ( keys %dirty_key ) {
        	print DATA "::$newKey";
  	}				
	close (DATA);
}

sub SearchDatabase {
	my $search;

	print "Enter a key word >";
    	chomp($search = <STDIN>);

	if( exists($dirty_key{$search} ) ){
		print "\"$search\" exists in database\n";
	}else{
		print "\"$search\" does not exist in database\n";
	}
}

sub ColorPicker {
	use Term::ANSIColor 2.02 qw(colorvalid);
	my $valid;
	while(!$valid)
	{
		print "Enter a color that will highlight your findings: ";
		chomp($color = <STDIN>);
       		$valid = colorvalid($color);
        	print $valid ? "\n" : "The color string is invalid. Please chose another color.\n";
	}	
	print color $color;
        print "Your findings will be printed in $color.\n";
	print color 'reset';
	return;
     
}

