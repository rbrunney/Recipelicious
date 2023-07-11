import React from 'react'
import { NavLink } from 'react-router-dom'

const Nav = () => {
    return (
        <div className='Nav'>
            <div>
                <NavLink to="/" className={({ isActive, isPending }) => isPending ? "Pending" : isActive ? "active" : ""}>
                    Home
                </NavLink>
            </div>
            <br />
            <div>
                <NavLink to="/register" className={({ isActive, isPending }) => isPending ? "Pending" : isActive ? "active" : ""}>
                    Register
                </NavLink>
            </div>
            <br />
            <div>
                <NavLink to="/candies" className={({ isActive, isPending }) => isPending ? "Pending" : isActive ? "active" : ""}>
                    Candies
                </NavLink>
            </div>

        </div>
    )
}

export default Nav