#
#This file is part of VESICLES.

#    VESICLES is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    VESICLES is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with VESICLES.  If not, see <http://www.gnu.org/licenses/>.

save2partslist <- function (name, part_seq)
{
  
  #remove all whitespace from the part's DNA
  part_seq<-gsub(" ", "", part_seq,fixed=TRUE) 
  part_seq<-gsub("\n", "", part_seq,fixed=TRUE)
  part_seq<-gsub("\t", "", part_seq,fixed=TRUE) 
  
  #convert all to uppercase as well
  part_seq<-toupper(part_seq)
  
  #check that part_seq only contains A,T,C or G characters
  part_seq_single_chars<-strsplit(part_seq, "")[[1]]
  
  for (i in part_seq_single_chars)
  {
    if ((i=='A') | (i=='T') | (i=='C') | (i=='G'))
    {
      valid_DNA<-TRUE
    }
    
    else
    {
      stop("Characters in part sequence are NOT valid DNA bases. Part was not added to parts list")
    }
  }
  
  if (valid_DNA)
  {
    print("All characters in part sequence are valid DNA bases")
  }
  
  #find if a partslist.txt already exists, load it if it does
  if (file.exists(paste0(getwd(),"/","partslist.txt")))
  {
    partslist<-read.table(paste0(getwd(),"/","partslist.txt"),stringsAsFactors=FALSE)
    
    #Check if part sequence is already present in parts list:
    if (is.na(match(part_seq,partslist[,2]))!=TRUE)
    {
      partNameOfDupSeq<-partslist[match(part_seq,partslist[,2]),1]
      
      stop(paste0('Duplicate of the sequence for part named: "',partNameOfDupSeq,'" was entered. Part was not added to parts list.'))
    }
    
    #Check if part name is already present in parts list:
    else if (is.na(match(name,partslist[,1]))!=TRUE)
    {
      stop(paste0('Part with name "',name,'"is already in the parts list, so the part just entered was not saved to the parts list. The part sequence just entered has NOT been added to the parts list before though :).'))
    }
    
    else
    {
      #save name and sequence to the parts list is BOTH are new entries
      new_entry_row<-c(name,part_seq)
      partslist<-rbind(partslist,new_entry_row)
      write.table(partslist, file=paste0(getwd(),"/","partslist.txt"))
      return(paste0(name,' has been added to partslist.txt :)'))
    }
    
  }
  
  #no existing parts list found, start a new one
  else
  {
    partname<-c()
    DNAseq<-c()
    partslist<-data.frame(partname,DNAseq)
    
    #save name and sequence to the parts list  
    new_entry_row<-c(name,part_seq)
    partslist<-rbind(partslist,new_entry_row)
    colnames(partslist) <- c('Part Name','DNA sequence')
    
    write.table(partslist, file=paste0(getwd(),"/","partslist.txt"))
    return(paste0(name,' has been added to the new file partslist.txt :)'))
    
  }
  
}
