function zipf -d "Create a ZIP archive of a folder"
    zip -r $argv[1].zip $argv[1]
end
