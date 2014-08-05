using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.Entity;
using System.Net;
using System.Web;
using FourthSource.Staffing.Data;

namespace WebApplication1.Controllers
{
    public class HomeController : Controller
    {
        private db4thStaffingEntities db = new db4thStaffingEntities();
        //
        // GET: /Home/
        public ActionResult Index()
        {
            var requests = from d in db.Requests
                           select d;

            return View(requests);
        }

        [HttpGet]
        public ViewResult Index(string qryRequest)
        {
            var requests = from d in db.Requests
                           orderby d.DateNeeded
                           select d;
            //db.Requests.Include(r => r.Company).Include(r => r.ResourceType1).Include(r => r.Status1);
            return View(requests);
        }

        //
        // GET: /Home/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        //
        // GET: /Home/Create
        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Home/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Home/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Home/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Home/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Home/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
