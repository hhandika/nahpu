//! An archive writer module.

use std::{
    io::BufReader,
    path::{Path, PathBuf},
};

pub struct ZipArchive<'a> {
    pub output_path: &'a Path,
    pub files: &'a [PathBuf],
}

impl<'a> ZipArchive<'a> {
    pub fn new(output_path: &'a Path, files: &'a [PathBuf]) -> Self {
        Self { output_path, files }
    }

    pub fn write(&self) -> Result<(), std::io::Error> {
        let mut zip = zip::ZipWriter::new(std::fs::File::create(self.output_path)?);
        let options =
            zip::write::FileOptions::default().compression_method(zip::CompressionMethod::Deflated);

        for file in self.files {
            let file_name = file
                .file_name()
                .expect("Failed getting file names")
                .to_str()
                .expect("Failed converting file names");
            zip.start_file(file_name, options)?;
            let inner = std::fs::File::open(file)?;
            let mut buff = BufReader::new(inner);
            std::io::copy(&mut buff, &mut zip)?;
        }

        zip.finish()?;

        Ok(())
    }
}
