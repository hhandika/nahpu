//! Rust FRB Boilerplate to access the archive API
use nahpu_api::archive::ZipArchive;
use std::path::{Path, PathBuf};

pub struct ZipWriter {
    pub parent_dir: String,
    pub alt_parent_dir: Option<String>,
    pub files: Vec<String>,
    pub output_path: String,
}

impl ZipWriter {
    pub fn new(parent_dir: String, files: Vec<String>, output_path: String) -> Self {
        Self {
            parent_dir,
            alt_parent_dir: None,
            files,
            output_path,
        }
    }

    pub fn write(&self) {
        let files: Vec<std::path::PathBuf> = self.files.iter().map(PathBuf::from).collect();
        let output_path = Path::new(&self.output_path);
        let parent_dir = Path::new(&self.parent_dir);
        let alt_parent_dir = self.alt_parent_dir.as_ref().map(Path::new);
        let zip = ZipArchive::new(parent_dir, alt_parent_dir, output_path, &files);
        zip.write().expect("Failed writing zip file");
    }
}
