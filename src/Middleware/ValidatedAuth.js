import { validationResult } from 'express-validator';

export default validationRequest = ( req, res, next ) => {
 
    const errors = validationResult( req ) ;

    if( !errors.isEmpty ){

        return res.status(400).json({
            resp: false,
            errors : errors.mapped()
        }); 
    }
    next();
}