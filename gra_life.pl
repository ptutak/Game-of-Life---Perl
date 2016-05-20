#!/usr/bin/perl

use Time::HiRes qw(usleep);

if (@ARGV<3)
{

	print "Podaj nazwe pliku\n";
	chomp($nazwa=<STDIN>);
	print "Podaj rozmiar planszy\n";
	chomp($rozmiar=<STDIN>);
	print "Podaj odstep czasowy w milisekundach\n";
	chomp($czas=<STDIN>);
	print "Podaj znak (domyslnie #)\n";
	$znak=<STDIN>;
	if (substr($znak,0,1) eq "\n")
	{
	$znak="#";
	}
	else
	{
	$znak=substr($znak,0,1);
	}

}
else
{
	$nazwa=$ARGV[0];
	$rozmiar=$ARGV[1];
	$czas=$ARGV[2]*1;

	if (@ARGV>=4)
	{
		$znak=substr($ARGV[3],0,1);
	}
	else
	{
	$znak="#";
	}

}

$czas*=1000;


my @tab_podst;
my @tab_kop;
$nr_wiersz=0;
if ($nazwa eq "STDIN")
{
	print "Wprowadz plansze:\n";
	while(($wiersz=<STDIN>)&&($nr_wiersz<$rozmiar))
	{
	$i=0;
	do
	{

		if ((ord(substr($wiersz,$i,1))>=ord("!")&&(ord(substr($wiersz,$i,1)))<=ord("~")))
		{
			$tab_podst[$nr_wiersz][$i]=$znak;
		}
		else
		{
			$tab_podst[$nr_wiersz][$i]=" ";
		}
		$i++;
	} while(($i<$rozmiar)&& (ord(substr($wiersz,$i,1))!=ord("\n")));

	while ($i<$rozmiar)
	{
		$tab_podst[$nr_wiersz][$i]=" ";
		$i++;
	}
	$nr_wiersz++;
	}
}
else
{


open(PLIK,$nazwa)||die "Nie mozna otworzyc pliku $nazwa\n";
while(($wiersz=<PLIK>)&&($nr_wiersz<$rozmiar))
{

	$i=0;
	do
	{

		if ((ord(substr($wiersz,$i,1))>=ord("!")&&(ord(substr($wiersz,$i,1)))<=ord("~")))
		{
			$tab_podst[$nr_wiersz][$i]=$znak;
		}
		else
		{
			$tab_podst[$nr_wiersz][$i]=" ";
		}
		$i++;
	} while(($i<$rozmiar)&& (ord(substr($wiersz,$i,1))!=ord("\n")));

	while ($i<$rozmiar)
	{
		$tab_podst[$nr_wiersz][$i]=" ";
		$i++;
	}

	$nr_wiersz++;
}
close PLIK;
}

while ($nr_wiersz<$rozmiar)
{

	$i=0;
	while ($i<$rozmiar)
	{
		$tab_podst[$nr_wiersz][$i]=" ";
		$i++;
	}
	$nr_wiersz++;
}


while (1)
{
	print "\033[2J";    #czyszczenie ekranu
	print "\033[0;0H";	#czyszczenie ekranu
	$i=0;
	while ($i<$rozmiar)
	{
		$j=0;
		print "|";
		while ($j<$rozmiar)
		{
			print " $tab_podst[$i][$j]";
			$j++;
		}
		print " |\n";
		$i++;
	}

	usleep($czas);

	for $i (0..$rozmiar-1)
	{
		for $j (0..$rozmiar-1)
		{
			$tab_kop[$i][$j]=$tab_podst[$i][$j];
		}
	}

	for $i (0..$rozmiar-1)
	{
		for $j (0..$rozmiar-1)
		{
			$licznik=0;
			if (ord($tab_kop[($i-1+$rozmiar)%$rozmiar][($j-1+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			if (ord($tab_kop[($i-1+$rozmiar)%$rozmiar][($j+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			if (ord($tab_kop[($i-1+$rozmiar)%$rozmiar][($j+1+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			if (ord($tab_kop[($i+$rozmiar)%$rozmiar][($j-1+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			if (ord($tab_kop[($i+$rozmiar)%$rozmiar][($j+1+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			if (ord($tab_kop[($i+1+$rozmiar)%$rozmiar][($j-1+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			if (ord($tab_kop[($i+1+$rozmiar)%$rozmiar][($j+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			if (ord($tab_kop[($i+1+$rozmiar)%$rozmiar][($j+1+$rozmiar)%$rozmiar])==ord($znak))
			{
				$licznik++;
			}
			
			if ((($licznik==2)||($licznik==3))&&(ord($tab_kop[$i][$j])==ord($znak)))
			{
				$tab_podst[$i][$j]=$znak;
			}
			elsif (($licznik==3)&&(ord($tab_kop[$i][$j])==ord(" ")))
			{
				$tab_podst[$i][$j]=$znak;
			}
			else
			{
				$tab_podst[$i][$j]=" ";
			}
	
		}
	}
}

	

