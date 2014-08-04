using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FourthSource.Staffing.Data;

namespace WebApplication1.Controllers
{
    public class RequestsController : Controller
    {
        private db4thStaffingEntities db = new db4thStaffingEntities();

        // GET: /Requests/
        public async Task<ActionResult> Index()
        {
            var requests = db.Requests.Include(r => r.Company).Include(r => r.PositionType1).Include(r => r.RequestType1).Include(r => r.ResourceType1).Include(r => r.Status1);
            return View(await requests.ToListAsync());
        }

        // GET: /Requests/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Request request = await db.Requests.FindAsync(id);
            if (request == null)
            {
                return HttpNotFound();
            }
            return View(request);
        }

        // GET: /Requests/Create
        public ActionResult Create()
        {
            ViewBag.CompanyNeeded = new SelectList(db.Companies, "Id", "Name");
            ViewBag.PositionType = new SelectList(db.PositionTypes, "Id", "PositionType1");
            ViewBag.RequestType = new SelectList(db.RequestTypes, "Id", "RequestType1");
            ViewBag.ResourceType = new SelectList(db.ResourceTypes, "Id", "Type");
            ViewBag.Status = new SelectList(db.Status, "Id", "Status1");
            return View();
        }

        // POST: /Requests/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include="Id,RequestNumber,Date,RequestType,DateNeeded,CompanyNeeded,ContactName,PositionType,Lenght,ResourceType,Position,YearsExp,Travel,AddtionalDetails,InternalComments,EnglishLevel,Status,Created,CreatedBy,LastModified,ModifiedBy,Version")] Request request)
        {
            if (ModelState.IsValid)
            {
                db.Requests.Add(request);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.CompanyNeeded = new SelectList(db.Companies, "Id", "Name", request.CompanyNeeded);
            ViewBag.PositionType = new SelectList(db.PositionTypes, "Id", "PositionType1", request.PositionType);
            ViewBag.RequestType = new SelectList(db.RequestTypes, "Id", "RequestType1", request.RequestType);
            ViewBag.ResourceType = new SelectList(db.ResourceTypes, "Id", "Type", request.ResourceType);
            ViewBag.Status = new SelectList(db.Status, "Id", "Status1", request.Status);
            return View(request);
        }

        // GET: /Requests/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Request request = await db.Requests.FindAsync(id);
            if (request == null)
            {
                return HttpNotFound();
            }
            ViewBag.CompanyNeeded = new SelectList(db.Companies, "Id", "Name", request.CompanyNeeded);
            ViewBag.PositionType = new SelectList(db.PositionTypes, "Id", "PositionType1", request.PositionType);
            ViewBag.RequestType = new SelectList(db.RequestTypes, "Id", "RequestType1", request.RequestType);
            ViewBag.ResourceType = new SelectList(db.ResourceTypes, "Id", "Type", request.ResourceType);
            ViewBag.Status = new SelectList(db.Status, "Id", "Status1", request.Status);
            return View(request);
        }

        // POST: /Requests/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include="Id,RequestNumber,Date,RequestType,DateNeeded,CompanyNeeded,ContactName,PositionType,Lenght,ResourceType,Position,YearsExp,Travel,AddtionalDetails,InternalComments,EnglishLevel,Status,Created,CreatedBy,LastModified,ModifiedBy,Version")] Request request)
        {
            if (ModelState.IsValid)
            {
                db.Entry(request).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.CompanyNeeded = new SelectList(db.Companies, "Id", "Name", request.CompanyNeeded);
            ViewBag.PositionType = new SelectList(db.PositionTypes, "Id", "PositionType1", request.PositionType);
            ViewBag.RequestType = new SelectList(db.RequestTypes, "Id", "RequestType1", request.RequestType);
            ViewBag.ResourceType = new SelectList(db.ResourceTypes, "Id", "Type", request.ResourceType);
            ViewBag.Status = new SelectList(db.Status, "Id", "Status1", request.Status);
            return View(request);
        }

        // GET: /Requests/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Request request = await db.Requests.FindAsync(id);
            if (request == null)
            {
                return HttpNotFound();
            }
            return View(request);
        }

        // POST: /Requests/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            Request request = await db.Requests.FindAsync(id);
            db.Requests.Remove(request);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
