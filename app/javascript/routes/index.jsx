import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Home from "../components/Home";
import Item from "../components/Item";
import Items from "../components/Items";

export default (
  <Router>
    <Routes>
      <Route path="/" exact element={<Home />} />
      <Route path="/item/:id" element={<Item />} />
      <Route path="/items" element={<Items />} />
    </Routes>
  </Router>
);
