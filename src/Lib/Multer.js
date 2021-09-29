import multer from 'multer';
import path from 'path';

var storageProfile = multer.diskStorage({

    destination: ( req, res, cb ) => {
        cb( null, 'src/Uploads/Profile')
    },
    filename: (req, file, cb) => {
        cb( null, file.fieldname + '-' + Date.now() + path.extname( file.originalname ))
    }

});

export const upLoadsProfile = multer({ storage: storageProfile });


var storageProducts = multer.diskStorage({

    destination: ( req, res, cb ) => {
        cb( null, 'src/Uploads/Products')
    },
    filename: (req, file, cb) => {
        cb( null, file.fieldname + '-' + Date.now() + path.extname( file.originalname ))
    }

});

export const upLoadsProducts = multer({ storage: storageProducts });