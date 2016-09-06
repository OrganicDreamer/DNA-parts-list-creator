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
