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
    public class MvItemInput
    {
        [Required]
        public MvValueInput[] Values { set; get; }
    }
    public class MvValueInput
    {
        public int Id { set; get; }
        public int FieldId { set; get; }
        [MaxLength(250)]
        public string StringValue { set; get; }
        public DateTime? DateValue { set; get; }
        public int? IntValue { set; get; }
        public int? OptionId { set; get; }
    }
    public class MvItemController : ApiController
    {
        // GET api/values
        public dynamic Get(int id)
        {
            using (var cnt = new MvContext())
            {
                var item = cnt.Items.Include("Values").Where(t => t.Id == id).Select(t => new
                {
                    Id = t.Id,
                    Values = t.Values.Select(it => new
                    {
                        Id = it.Id,
                        FieldId = it.FieldId,
                        StringValue = it.StringValue,
                        DateValue = it.DateValue,
                        IntValue = it.IntValue,
                        OptionId = it.OptionId
                    })
                }).SingleOrDefault();
                return item;
            }
        }
        public IEnumerable<dynamic> Get(int listId, bool listValues)
        {
            using (var cnt = new MvContext())
            {
                var items = cnt.Items.AsNoTracking().Where(t => t.ListId == listId).Select(t => new
                {
                    Id = t.Id,
                    Values = t.Values.Where(it => it.Field.Format != (int)MvFieldType.Multiple).Select(it => new
                    {
                        Id = it.Id,
                        FieldId = it.FieldId,
                        StringValue = it.StringValue,
                        DateValue = it.DateValue,
                        IntValue = it.IntValue,
                        OptionId = it.OptionId,
                        OptionTitle = it.Option.Title
                    })
                }).ToArray();
                return items;
            }
        }

        // POST api/values
        public dynamic Post(int listId, MvItemInput input)
        {
            if (ModelState.IsValid && input != null)
            {
                using (var cnt = new MvContext())
                {
                    if (cnt.Lists.Any(t => t.Id == listId))
                    {
                        var values = input.Values.Select(t => new MvValue() { FieldId = t.FieldId, StringValue = t.StringValue, DateValue = t.DateValue, IntValue = t.IntValue, OptionId = t.OptionId, Modified = DateTime.Now }).ToList();
                        var item = new MvItem() { ListId = listId, Values = values, Modified = DateTime.Now };
                        cnt.Items.Add(item);
                        cnt.SaveChanges();
                        return new { Id = item.Id };
                    }
                }
            }
            return new { };
        }

        public dynamic Put(int id, MvItemInput input)
        {
            if (ModelState.IsValid && input != null)
            {
                using (var cnt = new MvContext())
                {
                    var item = cnt.Items.Include("Values").Where(t => t.Id == id).SingleOrDefault();
                    if (item != null)
                    {
                        item.Modified = DateTime.Now;
                        var inputValues = input.Values.Where(t => t.Id > 0).ToDictionary(t => t.Id, t => t);

                        foreach (var value in item.Values.Where(t => inputValues.ContainsKey(t.Id)).ToArray())
                        {
                            var inputValue = inputValues[value.Id];
                            value.StringValue = inputValue.StringValue;
                            value.IntValue = inputValue.IntValue;
                            value.DateValue = inputValue.DateValue;
                            value.OptionId = inputValue.OptionId;
                            value.Modified = DateTime.Now;
                        }

                        var removeValues = item.Values.Where(t => !inputValues.ContainsKey(t.Id)).ToArray();
                        foreach (var value in removeValues)
                            cnt.Values.Remove(value);

                        var newValues = input.Values.Where(t => t.Id == 0).Select(t => new MvValue() { FieldId = t.FieldId, StringValue = t.StringValue, DateValue = t.DateValue, IntValue = t.IntValue, OptionId = t.OptionId, Modified = DateTime.Now }).ToArray();
                        foreach (var value in newValues)
                            item.Values.Add(value);

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
                var item = cnt.Items.Where(t => t.Id == id).SingleOrDefault();
                if (item != null)
                {
                    cnt.Items.Remove(item);
                    cnt.SaveChanges();
                }
            }
        }
    }
}