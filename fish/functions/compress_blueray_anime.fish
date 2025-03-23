function compress_blueray_anime --description 'Compress an input video file using the values I tested for my Ghost in the Shell blueray files';
    ab-av1 encode --input $argv[1] --keyint 240 --scd false --svt film-grain=4 --svt tune=3 --svt smc=0 --preset 4 --crf 14
end