import { response } from 'express';
import pool from '../Database/mysql';

export const addCategories = async (req, res = response) => {

    try {

        const { category, description } = req.body;

        await pool.query(`CALL SP_ADD_CATEGORY(?,?);`, [ category, description ]);

        res.json({
            resp: true,
            msg : 'Category added successfully',
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        }); 
    }
}

export const getAllCategories = async ( req, res = response ) => {

    try {

        const category = await pool.query('SELECT * FROM categories');

        res.json({
            resp: true,
            msg : 'All Categories',
            categories: category
        });
        
    } catch (e) {
        return res.status(500).json({
            resp: false,
            msg : e
        });
    }

}

