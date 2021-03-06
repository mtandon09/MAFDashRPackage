#' Function to generate silent and non-silent mutation plot
#' @description This function generates silent and non-silent
#' mutation plot using the MAF data.
#' @author Mayank Tondon, Ashish Jain
#' @param mymaf The MAF object
#' @param savename The name and path of the output file
#' @param returndata Flag to output the plot data (By Default
#' returndata = FALSE)
#' @export
#' @return The ggplot object if returndata is FALSE or a list
#' containing the ggplot object and plot data if returndata
#' is TRUE
#'
#' @examples
#' library(MAFDashRPackage)
#' laml.maf <- system.file("extdata", "tcga_laml.maf.gz", package = "maftools")
#' generateMutationTypePlot(read.maf(laml.maf))
#'
generateMutationTypePlot<-function(mymaf, savename=NULL, returndata=FALSE){
  ### Add checks for the conditions
  mymaf <- ensurer::ensure_that(mymaf,
                                !is.null(.) && (class(.) == "MAF"),
                                err_desc = "Please enter correct MAF object")
  returndata <- ensurer::ensure_that(returndata,
                                    !is.null(.) && (class(.) == "logical"),
                                    err_desc = "Please enter the returndata flag in correct format.")

  nonsilent_summary <- mymaf@variant.classification.summary[,c("Tumor_Sample_Barcode","total")]
  nonsilent_summary$type <- "Non-Silent"
  silent_classif_data <- mymaf@maf.silent %>% group_by(Tumor_Sample_Barcode, Variant_Classification) %>% summarise(count=n())
  silent_classif_data <- reshape2::dcast(silent_classif_data,Tumor_Sample_Barcode ~ Variant_Classification, value.var = "count")
  silent_summary <- data.frame(Tumor_Sample_Barcode = silent_classif_data$Tumor_Sample_Barcode,
                               total = rowSums(silent_classif_data[,-1], na.rm=T),
                               type = "Silent"
  )

  # browser()
  plotdata <- rbind(nonsilent_summary, silent_summary)
  tots <- plotdata %>% group_by(Tumor_Sample_Barcode) %>% summarise(tot=sum(total))
  plotdata$Tumor_Sample_Barcode <- factor(plotdata$Tumor_Sample_Barcode,
                                          levels=as.character(tots$Tumor_Sample_Barcode)[order(tots$tot,decreasing = T)])
  myplot <- ggplot(plotdata, aes(x=Tumor_Sample_Barcode, y = total, fill=type)) +
    geom_col() + scale_fill_brewer(palette="Set1") +
    theme_linedraw(base_size = 12) +
    xlab("")+
    theme(plot.title = element_text(hjust = 0.5),
          axis.text.x = element_text(angle=30, hjust = 1, size=10),
          axis.ticks.x = element_blank())

  if (!is.null(savename)) {
    if (! dir.exists(dirname(savename))) {dir.create(dirname(savename), recursive = T)}
    ggsave(savename,width=6, height=6)
  }
  return_val <- myplot
  if (returndata) {
    return_val <- list(plot=myplot, data=plotdata)
  }
  return(return_val)
}
