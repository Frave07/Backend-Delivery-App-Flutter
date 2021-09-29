import { Router } from 'express';
import { verifyToken } from '../Middleware/ValidateToken';
import * as login from '../Controller/LoginController';

const router = Router();


router.post('/login-email-id', login.loginController);
router.get('/renew-token-login', verifyToken ,login.renewTokenLogin);



export default router;