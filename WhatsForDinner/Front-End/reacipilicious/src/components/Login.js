import React, { useState, useEffect } from 'react';
import { Link, useSearchParams } from 'react-router-dom';

const Login = () => {
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");


    return (
        <div id='loginPage'>

            <section class="App-header">
                <div class="container py-5 h-100">
                    <div class="row d-flex align-items-center justify-content-center h-100">
                        <div class="col-md-8 col-lg-7 col-xl-6">
                            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg"
                                class="img-fluid" alt="Phone image" />
                        </div>
                        <div class="col-md-7 col-lg-5 col-xl-5 offset-xl-1">
                            <form>

                                <div class="form-outline mb-4">
                                    <label class="form-label" for="form1Example13">Email address</label>
                                    <input type="email" id="form1Example13" class="form-control form-control-lg" />
                                </div>

                                <div class="form-outline mb-4">
                                    <label class="form-label" for="form1Example23">Password</label>
                                    <input type="password" id="form1Example23" class="form-control form-control-lg" />
                                </div>

                                <div class="d-flex justify-content-around align-items-center mb-4">

                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="form1Example3" checked />
                                        <label class="form-check-label" for="form1Example3"> Remember me </label>
                                    </div>
                                    <a href="#!">Forgot password?</a>
                                </div>


                                <button type="submit" class="btn btn-primary btn-lg btn-block">Sign in</button>

                            </form>
                        </div>
                    </div>
                </div>
            </section>

        </div>
    )
}

export default Login