using MyvaData.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace MyvaData.Controllers
{
    public class MvOptionInput
    {
        [MaxLength(250)]
        public string Title { set; get; }
        public int Order { set; get; }
    }
    public class MvOptionController : ApiController
    {
        public dynamic Post(int fieldId, MvOptionInput input)
        {
            if (ModelState.IsValid && input != null)
            {
                using (var cnt = new MvContext())
                {
                    if (cnt.Fields.Any(t => t.Id == fieldId))
                    {
                        var item = new MvOption() { FieldId = fieldId, Title = input.Title, Order = input.Order, Modified = DateTime.Now };
                        cnt.Options.Add(item);
                        cnt.SaveChanges();
                        return new { Id = item.Id };
                    }
                }
            }
            return new { };
        }

        public dynamic Put(int id, MvOptionInput input)
        {
            if (ModelState.IsValid && input != null)
            {
                using (var cnt = new MvContext())
                {
                    var item = cnt.Options.Where(t => t.Id == id).SingleOrDefault();
                    if (item != null)
                    {
                        item.Title = input.Title;
                        item.Order = input.Order;
                        item.Modified = DateTime.Now;
                        cnt.SaveChanges();
                        return new { Id = item.Id };
                    }
                }
            }
            return new { };
        }
    }
}