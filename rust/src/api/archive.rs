//! Rust FRB Boilerplate to access the archieve API

use nahpu_api::archive::ZipArchive;

pub struct ZipWriter {
    pub output_path: String,
    pub files: Vec<String>,
}

impl ZipWriter {
    pub fn new(output_path: String, files: Vec<String>) -> Self {
        Self { output_path, files }
    }

    pub fn write(&self) {
        let files: Vec<std::path::PathBuf> = self
            .files
            .iter()
            .map(|f| std::path::PathBuf::from(f))
            .collect();
        let output_path = std::path::Path::new(&self.output_path);
        let zip = ZipArchive::new(output_path, &files);
        zip.write().expect("Failed writing zip file");
    }
}
