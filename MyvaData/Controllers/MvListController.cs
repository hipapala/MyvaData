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
    public class MvListInput
    {
        public int Id { set; get; }
        [Required]
        [MaxLength(250)]
        public string Title { set; get; }
    }

    public class MvListController : ApiController
    {
        // GET api/<controller>
        public IEnumerable<dynamic> Get()
        {
            using (var cnt = new MvContext())
            {
                var items = cnt.Lists.Select(t => new { Id = t.Id, Title = t.Title }).ToArray();
                return items;
            }
        }

        // GET api/<controller>/5
        public dynamic Get(int id, bool fieldsSingleValue = false)
        {
            using (var cnt = new MvContext())
            {
                var item = cnt.Lists.Where(t => t.Id == id).Select(t => new { Id = t.Id, Title = t.Title }).SingleOrDefault();
                if (item != null)
                {
                    var fieldsQuery = cnt.Fields.Include("Options").Where(t => t.ListId == id);
                    if (fieldsSingleValue)
                    {
                        fieldsQuery = fieldsQuery.Where(t => t.Format != (int)MvFieldType.Multiple);
                    }
                    var fields = fieldsQuery.ToArray();
                    return new { Id = item.Id, Title = item.Title, Fields = fields.Select(t => new { Id = t.Id, Format = (MvFieldType)t.Format, Title = t.Title, IsRequired = t.IsRequired, Order = t.Order, Options = t.Options.Select(it => new { Id = it.Id, Title = it.Title, Order = it.Order }).OrderBy(it => it.Order) }).OrderBy(t => t.Order) };
                }
                return null;
            }
        }

        public dynamic Post(MvListInput input)
        {
            if (ModelState.IsValid && input != null)
            {
                using (var cnt = new MvContext())
                {
                    var item = cnt.Lists.Where(t => t.Id == input.Id).SingleOrDefault();
                    if (item == null)
                    {
                        item = new MvList();
                        cnt.Lists.Add(item);
                    }
                    item.Title = input.Title;
                    item.Modified = DateTime.Now;
                    cnt.SaveChanges();
                    return new { Id = item.Id };
                }
            }
            return new { };
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
            using (var cnt = new MvContext())
            {
                var item = cnt.Lists.Where(t => t.Id == id).SingleOrDefault();
                if (item != null)
                {
                    cnt.Lists.Remove(item);
                    cnt.SaveChanges();
                }
            }
        }
    }
}