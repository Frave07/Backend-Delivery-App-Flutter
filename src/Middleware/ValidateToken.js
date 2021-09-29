import jwt from 'jsonwebtoken';


export const verifyToken = ( req, res, next ) => {

    try {

        let token = req.header('xx-token');

        if( !token ){
            return res.status(401).json({
                resp: false,
                msg : 'There is not Token in the request'
            });
        }

        const { uidPerson } = jwt.verify( token, process.env.APP_KEY_JWT );

        req.uid = uidPerson;

        next();
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e.message,
            user: { uid: 0, firstName: '', lastName: '', image: '', email: '', rol_id: 0 },
            token: ''
        });
    }

}