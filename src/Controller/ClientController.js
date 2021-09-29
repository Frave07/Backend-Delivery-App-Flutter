import { response } from 'express';
import pool from '../Database/mysql';


export const getListOrdersForClient = async (req, res = response) => {

    try {

        const listdb = await pool.query(`CALL SP_ORDERS_FOR_CLIENT(?);`, [req.uid]);

        res.json({
            resp: true,
            msg : 'List orders for client',
            ordersClient: listdb[0]
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}