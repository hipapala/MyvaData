using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace MyvaData.Models
{
    public class MvContext : DbContext
    {   
        public MvContext()
            : base()
        {
            Database.SetInitializer<MvContext>(null);
            this.Configuration.ProxyCreationEnabled = false;
        }
        public DbSet<MvList> Lists { get; set; }
        public DbSet<MvField> Fields { get; set; }
        public DbSet<MvOption> Options { get; set; }
        public DbSet<MvItem> Items { get; set; }
        public DbSet<MvValue> Values { get; set; }
    }

    [Table("public.MV_List")]
    public partial class MvList
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("id")]
        public int Id { get; set; }
        [Column("title")]
        public string Title { get; set; }
        [Column("modified")]
        public DateTime Modified { get; set; }

        public virtual ICollection<MvField> Fields { set; get; }
    }

    [Table("public.MV_Field")]
    public partial class MvField
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("id")]
        public int Id { get; set; }
        [Column("format")]
        public int Format { get; set; }
        [Column("title")]
        public string Title { get; set; }
        [Column("required")]
        public bool IsRequired { get; set; }
        [ForeignKey("List")]
        [Column("group_id")]
        public int ListId { get; set; }
        [Column("order")]
        public int Order { get; set; }
        [Column("modified")]
        public DateTime Modified { get; set; }

        public virtual MvList List { set; get; }
        public virtual ICollection<MvOption> Options { set; get; }
    }

    [Table("public.MV_Option")]
    public partial class MvOption
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("id")]
        public int Id { get; set; }
        [ForeignKey("Field")]
        [Column("field_id")]
        public int FieldId { get; set; }
        [Column("title")]
        public string Title { get; set; }
        [Column("order")]
        public int Order { get; set; }
        [Column("modified")]
        public DateTime Modified { get; set; }

        public virtual MvField Field { set; get; }
    }

    [Table("public.MV_Item")]
    public partial class MvItem
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("id")]
        public int Id { get; set; }
        [ForeignKey("List")]
        [Column("group_id")]
        public int ListId { get; set; }
        [Column("modified")]
        public DateTime Modified { get; set; }

        public virtual MvList List { set; get; }
        public virtual ICollection<MvValue> Values { set; get; }
    }

    [Table("public.MV_Value")]
    public partial class MvValue
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("id")]
        public int Id { get; set; }
        [ForeignKey("Item")]
        [Column("item_id")]
        public int ItemId { get; set; }
        [ForeignKey("Field")]
        [Column("field_id")]
        public int FieldId { get; set; }
        [Column("string_v")]
        public string StringValue { get; set; }
        [Column("int_v")]
        public int? IntValue { get; set; }
        [Column("date_v")]
        public DateTime? DateValue { get; set; }
        [ForeignKey("Option")]
        [Column("list_id")]
        public int? OptionId { get; set; }
        [Column("modified")]
        public DateTime Modified { get; set; }

        public virtual MvOption Option { set; get; }
        public virtual MvItem Item { set; get; }
        public virtual MvField Field { set; get; }
    }
}