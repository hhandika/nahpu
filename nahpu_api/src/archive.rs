//! An archive writer module.

use std::{
    io::BufReader,
    path::{Path, PathBuf},
};

pub struct ZipArchive<'a> {
    /// The parent directory of the files to be archived.
    /// This is used to create the directory structure in the archive.
    pub parent_dir: &'a Path,
    /// Alternative parent directory to be used in the archive.
    /// This is used to create the directory structure
    /// if the parent directory is not present.
    pub alt_parent_dir: Option<&'a Path>,
    /// The files to be archived.
    pub files: &'a [PathBuf],
    /// The path to the output file.
    pub output_path: &'a Path,
}

impl<'a> ZipArchive<'a> {
    pub fn new(
        parent_dir: &'a Path,
        alt_parent_dir: Option<&'a Path>,
        output_path: &'a Path,
        files: &'a [PathBuf],
    ) -> Self {
        Self {
            parent_dir,
            alt_parent_dir,
            files,
            output_path,
        }
    }

    pub fn write(&self) -> Result<(), std::io::Error> {
        let mut zip = zip::ZipWriter::new(std::fs::File::create(self.output_path).unwrap());
        let options = zip::write::FileOptions::default()
            .compression_method(zip::CompressionMethod::Deflated)
            .large_file(true);

        for file in self.files {
            let file_path = self.parse_file_path(file);
            let inner = std::fs::File::open(file)?;
            let mut buff = BufReader::new(inner);
            zip.start_file(file_path, options)?;

            std::io::copy(&mut buff, &mut zip)?;
        }

        zip.finish()?;
        Ok(())
    }

    fn parse_file_path(&self, file: &Path) -> String {
        let file_name = Path::new(file.file_name().unwrap_or_else(|| {
            panic!("Failed parsing file name: {:?}", file);
        }));
        let prefix = file.strip_prefix(self.parent_dir);
        let file_path = match prefix {
            Ok(p) => p,
            // If the file is not in the parent directory,
            // use the alternative parent directory.
            // Otherwise, use the file name.
            Err(_) => file
                .strip_prefix(self.alt_parent_dir.unwrap_or(file_name))
                .unwrap_or(file_name),
        };
        file_path
            .to_str()
            .expect("Failed parsing file path")
            .to_string()
    }
}
