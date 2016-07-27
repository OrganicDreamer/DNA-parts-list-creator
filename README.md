# What it does #

* Removes ALL whitespace and capitalizes ALL bases in DNA sequences

* Checks the part's DNA sequence to make sure it only contains A, T, C or G. Will NOT allow sequences with non-ATCG characters to be added. 

* Checks the part's name and DNA sequence to see if it is a duplicate of something already in partslist.txt. Will NOT allow duplicate part names or duplicate sequences to be added to partslist.txt. For attempts to add duplicate sequences to the parts list, the part name of the sequence being duplicated will be identified. 

* Creates a text file (if none already exists) and saves part name and sequence to partslist.txt

* Updates partslist.txt (if it already exists) with new part name and sequence

### To initially set up ###

1. Download and open save2partslist.R in RStudio or with R. 

2. Set working directory to same folder as save2partslist.R. In RStudio go to Session->Set Working Directory->To Source File Location.

3. Run the script. In RStudio the keyboard shortcut is Ctrl+Alt+R. This defines the function save2partslist()

### To use after set up ###

1. In R (CONSOLE WINDOW ONLY, YOU BIOLOGISTS!!!) type: save2partslist("the part's name","the part's sequence")

2. Go to folder where save2partslist.R is saved, open partslist.txt to view your parts list. 

# To remove parts from the parts list #

1. If there is only 1 part in the list, just delete partslist.txt and start a new parts list. 

2. If there are 2+ parts in the parts list, download and open deleteLotsOfPartsFromList.R in RStudio or with R.

  1. Set working directory to same folder as this R file. In RStudio go to Session->Set Working Directory->To Source File Location.

  2. Run the script. In RStudio the keyboard shortcut is Ctrl+Alt+R. This defines the function deleteLotsOfPartsFromList()

  3. In R console window, for as many parts as you want to delete type: deleteLotsOfPartsFromList("part name 1", "part name 2", "part name 3"). 






