#!/bin/sh

cd /Users/KCJ/Desktop/subsetting_for_manuscript_1kg 

echo "subsetting sample populations"

for i in {1..22}
do
	echo "processing " ${i} 
	bcftools index ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
	bcftools view ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -S populations.txt -v snps -O z -o subset/1kg.subset.chr${i}.vcf.gz
	
	echo "removing temp files"
	rm ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
	rm ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.csi
done

cd /Users/KCJ/Desktop/subsetting_for_manuscript_1kg/subset

echo "subsetting regions of interest"


for i in {1..22}
do 
	echo "processing " ${i} 
	bcftools index 1kg.subset.chr${i}.vcf.gz
	bcftools view 1kg.subset.chr${i}.vcf.gz -R positions.txt -O z -o concat/1kg.starchstudy.chr${i}.vcf.gz
	
	echo "removing temp files"
	rm 1kg.subset.chr${i}.vcf.gz
	rm 1kg.subset.chr${i}.vcf.gz.csi
done

cd /Users/KCJ/Desktop/subsetting_for_manuscript_1kg/subset/concat

echo "concatenating chromosome files"

bcftools index 1kg.starchstudy.chr${i}.vcf.gz
bcftools concat 1kg.starchstudy.chr1.vcf.gz 1kg.starchstudy.chr2.vcf.gz 1kg.starchstudy.chr3.vcf.gz 1kg.starchstudy.chr4.vcf.gz 1kg.starchstudy.chr5.vcf.gz 1kg.starchstudy.chr6.vcf.gz 1kg.starchstudy.chr7.vcf.gz 1kg.starchstudy.chr8.vcf.gz 1kg.starchstudy.chr9.vcf.gz 1kg.starchstudy.chr10.vcf.gz 1kg.starchstudy.chr11.vcf.gz 1kg.starchstudy.chr12.vcf.gz 1kg.starchstudy.chr13.vcf.gz 1kg.starchstudy.chr14.vcf.gz 1kg.starchstudy.chr15.vcf.gz 1kg.starchstudy.chr16.vcf.gz 1kg.starchstudy.chr17.vcf.gz 1kg.starchstudy.chr18.vcf.gz 1kg.starchstudy.chr19.vcf.gz 1kg.starchstudy.chr20.vcf.gz 1kg.starchstudy.chr21.vcf.gz 1kg.starchstudy.chr22.vcf.gz -O z -o final/1kg.starch_study_dataset.vcf.gz

echo "removing temp files"

for i in {1..22}
do 
	rm 1kg.starchstudy.chr${i}.vcf.gz
	rm 1kg.starchstudy.chr${i}.vcf.gz.csi
done

cd /Users/KCJ/Desktop/subsetting_for_manuscript_1kg/subset/concat/final
bcftools index 1kg.starch_study_dataset.vcf.gz

echo "finished"

open .

