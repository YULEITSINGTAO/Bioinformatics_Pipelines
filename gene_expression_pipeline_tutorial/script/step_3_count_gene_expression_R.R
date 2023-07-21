library(data.table)

read_per_gen_tab_list <- list.files(path = "../dataset/bam_file", pattern="*ReadsPerGene.out.tab$", full.names = TRUE)
sample_name <- gsub("ReadsPerGene.out.tab", "", basename(read_per_gen_tab_list))
sample_map <- data.frame(sample_name, read_per_gen_tab_list)

temp <- lapply(read_per_gen_tab_list, fread, sep="\t")
data <- do.call(cbind,lapply(read_per_gen_tab_list,read.table))
data <- data[-c(1:4),]
rownames(data) <- data[[1]]
data <- data[, seq(2,ncol(data),by = 4)]
colnames(data) <- sample_name

saveRDS(data,file="../dataset/raw_count_matrix/raw_count_matrix.rds")
fwrite(data,file="../dataset/raw_count_matrix/raw_count_matrix.csv")
