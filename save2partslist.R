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
    
    #save name and sequence to the parts list  
    new_entry_row<-c(name,part_seq)
    partslist<-rbind(partslist,new_entry_row)
    
    #Undo adding the new part if it is a duplicate
    if (anyDuplicated(partslist)>0)
    {
      partslist<-partslist[(nrow(partslist)-1),]
      return("Complete duplicate part detected. Part was not added to parts list.")
    }

    if (anyDuplicated(partslist[,2])>0)
    {
      #List of sequences in the parts list
      sequencesInPartsList<-data.frame(seq=table[,2])
       
      #Apply duplicated() in both forward and reverse order of list of sequences
      #Create combined logical vector of this
      #Equidistant TRUE values in the vector elements correspond to duplicated sequences:
      whichAreDuplicates<-duplicated(sequencesInPartsList) | duplicated(sequencesInPartsList, fromLast = TRUE)
       
      #Determing which part's sequence the recently added sequence is a duplicate of (will be first TRUE in whichAreDuplicates)
      for (j in whichAreDuplicates)
      {
        if (j==TRUE)
        {
          #Get index via which() and hence the part name of sequence that has been duplicated
          firstInstanceOfDuplicate<-partslist[which(j==TRUE),1]
          break
        }
      }

      #Remove recently added duplicate:
      partslist<-partslist[(nrow(partslist)-1),]
      
      return(paste0("Duplicate sequence detected. Duplicate of the sequence for the part named: ",firstInstanceOfDuplicate,". Part was not added to parts list."))
    }

    if (anyDuplicated(partslist[,1])>0)
    {
      partslist<-partslist[(nrow(partslist)-1),]
      return("Duplicate part name detected. Part was not added to parts list.")
    }
    
    
    write.table(partslist, file=paste0(getwd(),"/","partslist.txt"))
    
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
    
  }
  
}
