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
    [Newtonsoft.Json.JsonConverter(typeof(Newtonsoft.Json.Converters.StringEnumConverter))]
    public enum MvFieldType { Text, Select, Multiple, Date, Number }
    public class MvFieldInput
    {
        public MvFieldType Format { set; get; }
        [MaxLength(250)]
        public string Title { set; get; }
        public bool IsRequired { set; get; }
        public int Order { set; get; }
        public MvOptionInput[] Options { set; get; }
    }
    public class MvFieldController : ApiController
    {
        // GET api/values
        public IEnumerable<dynamic> Get(int listId, bool singleValue = false)
        {
            using (var cnt = new MvContext())
            {
                var query = cnt.Fields.Include("Options").Where(t => t.ListId == listId);
                if (singleValue)
                {
                    query = query.Where(t => t.Format != (int)MvFieldType.Multiple);
                }
                var items = query.ToArray();
                return items.Select(t => new { Id = t.Id, Format = (MvFieldType)t.Format, Title = t.Title, Required = t.IsRequired, Order = t.Order, Options = t.Options.Select(it => new { Id = it.Id, Title = it.Title, Order = it.Order }).OrderBy(it => it.Order) }).OrderBy(t => t.Order);
            }
        }

        // POST api/values
        public dynamic Post(int listId, MvFieldInput input)
        {
            if (ModelState.IsValid && input != null)
            {
                using (var cnt = new MvContext())
                {
                    if (cnt.Lists.Any(t => t.Id == listId))
                    {
                        var field = new MvField() { ListId = listId, Format = (int)input.Format, IsRequired = input.IsRequired, Title = input.Title, Order = input.Order, Modified = DateTime.Now };
                        cnt.Fields.Add(field);
                        cnt.SaveChanges();
                        return new { Id = field.Id };
                    }
                }
            }
            return new { };
        }

        public dynamic Put(int id, MvFieldInput input)
        {
            if (ModelState.IsValid && input != null)
            {
                using (var cnt = new MvContext())
                {
                    var item = cnt.Fields.Where(t => t.Id == id).SingleOrDefault();
                    if (item != null)
                    {
                        item.IsRequired = input.IsRequired;
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

        // DELETE api/values/5
        public void Delete(int id)
        {
            using (var cnt = new MvContext())
            {
                var item = cnt.Fields.Where(t => t.Id == id).SingleOrDefault();
                if (item != null)
                {
                    cnt.Fields.Remove(item);
                    cnt.SaveChanges();
                }
            }
        }
    }
}