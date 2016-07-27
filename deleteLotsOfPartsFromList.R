deleteLotsOfPartsFromList<-function(...)
{
  partNamesToDelete<-c(...)
  
  for (i in partNamesToDelete)
  {
    deleteFromPartsList(i)
  }

}

deleteFromPartsList <- function (part_name)
{
  if (file.exists(paste0(getwd(),"/","partslist.txt")))
  {
    #load parts list if it exists in the folder
    partslist<-read.table(paste0(getwd(),"/","partslist.txt"),stringsAsFactors=FALSE)
    
    #extract part names in the parts list
    partNamesInList<-partslist[,1]
    
    if (part_name%in%partNamesInList)
    {
      rowToDelete<-match(part_name,partNamesInList)
      partslist<-partslist[-c(rowToDelete),]
      print(paste0(part_name,' has been removed from the parts list.'))
      
    }
    else
    {
      stop("Part name you are trying delete is not found in the parts list and therefore nothing was deleted.")
    }
    
    
    #save updated parts list to folder
    write.table(partslist, file=paste0(getwd(),"/","partslist.txt"))
    
  }
  
  else
  {
    stop("No parts list found in folder. Please make sure partslist.txt is in the directory.")
  }
  
}