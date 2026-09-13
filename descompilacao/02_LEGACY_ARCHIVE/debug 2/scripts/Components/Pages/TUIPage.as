package Components.Pages
{
   import Components.Standard.TUIButton;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Resources.Constants.CONST_COMMON;
   import flash.text.TextField;
   
   public class TUIPage extends TUIComponent
   {
      
      public static const STRING_Capacity:String = CONST_COMMON.STRING_Capacity;
      
      protected var FButtonPrevious:TUIButton;
      
      protected var FButtonNext:TUIButton;
      
      protected var FLabelPage:TextField;
      
      protected var FTotalQuantity:uint;
      
      protected var FPageSize:uint;
      
      protected var FPageIndex:int;
      
      protected var FTotalPage:uint;
      
      protected var FInitialization:Boolean;
      
      protected var FOnChangePage:Function;
      
      public function TUIPage(param1:TUIComponent)
      {
         super(param1);
         this.FButtonPrevious = new TUIButton(this);
         this.FButtonPrevious.OnClick = this.ButtonPreviousPageOnClick;
         this.FButtonNext = new TUIButton(this);
         this.FButtonNext.OnClick = this.ButtonNextPageOnClick;
         this.FInitialization = false;
      }
      
      protected function Initialization() : void
      {
         this.FButtonPrevious.Init();
         this.FButtonNext.Init();
         this.FButtonPrevious.SetButtonEnabled(false);
         this.FButtonNext.SetButtonEnabled(false);
         this.FInitialization = true;
      }
      
      protected function UpdateLabelPage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         _loc1_ = this.FPageIndex;
         _loc2_ = int(this.FTotalPage);
         if(this.FTotalPage <= 0)
         {
            _loc1_ = 1;
            _loc2_ = 1;
         }
         else
         {
            _loc1_++;
         }
         if(this.FLabelPage != null)
         {
            this.FLabelPage.text = TUtilityString.Format(STRING_Capacity,_loc1_,_loc2_);
         }
      }
      
      protected function UpdateTotalPage() : void
      {
         this.FTotalPage = Math.floor(this.FTotalQuantity / this.FPageSize * -1) * -1;
      }
      
      protected function ButtonPreviousPageOnClick(param1:Object) : void
      {
         if(this.FPageIndex > 0)
         {
            --this.FPageIndex;
            this.UpdateLabelPage();
         }
         if(this.FPageIndex == 0)
         {
            if(this.FButtonPrevious.IsEnabled)
            {
               this.FButtonPrevious.SetButtonEnabled(false);
            }
         }
         this.PageIndex = this.FPageIndex;
         if(this.FOnChangePage != null)
         {
            this.FOnChangePage(this,this.FPageIndex);
         }
      }
      
      protected function ButtonNextPageOnClick(param1:Object) : void
      {
         if(this.FPageIndex + 1 < this.FTotalPage)
         {
            ++this.FPageIndex;
            this.UpdateLabelPage();
         }
         if(this.FPageIndex == this.FTotalPage - 1)
         {
            if(this.FButtonNext.IsEnabled)
            {
               this.FButtonNext.SetButtonEnabled(false);
            }
         }
         this.PageIndex = this.FPageIndex;
         if(this.FOnChangePage != null)
         {
            this.FOnChangePage(this,this.FPageIndex);
         }
      }
      
      public function UpdateLabelView() : void
      {
         this.UpdateTotalPage();
      }
      
      public function get ButtonPrevious() : TUIButton
      {
         return this.FButtonPrevious;
      }
      
      public function set ButtonPrevious(param1:TUIButton) : void
      {
         this.FButtonPrevious = param1;
      }
      
      public function get ButtonNext() : TUIButton
      {
         return this.FButtonNext;
      }
      
      public function set ButtonNext(param1:TUIButton) : void
      {
         this.FButtonNext = param1;
      }
      
      public function get TotalQuantity() : uint
      {
         return this.FTotalQuantity;
      }
      
      public function set TotalQuantity(param1:uint) : void
      {
         this.FTotalQuantity = param1;
      }
      
      public function get PageSize() : uint
      {
         return this.FPageSize;
      }
      
      public function set PageSize(param1:uint) : void
      {
         this.FPageSize = param1;
      }
      
      public function get LabelPage() : TextField
      {
         return this.FLabelPage;
      }
      
      public function set LabelPage(param1:TextField) : void
      {
         this.FLabelPage = param1;
      }
      
      public function get OnChangePage() : Function
      {
         return this.FOnChangePage;
      }
      
      public function set OnChangePage(param1:Function) : void
      {
         this.FOnChangePage = param1;
      }
      
      public function set PageIndex(param1:int) : void
      {
         this.FPageIndex = param1;
         this.FButtonNext.SetButtonEnabled(true);
         this.FButtonPrevious.SetButtonEnabled(true);
         if(param1 >= this.FTotalPage - 1)
         {
            if(this.FButtonNext.IsEnabled)
            {
               this.FButtonNext.SetButtonEnabled(false);
            }
         }
         if(param1 <= 0)
         {
            if(this.FButtonPrevious.IsEnabled)
            {
               this.FButtonPrevious.SetButtonEnabled(false);
            }
         }
         this.FPageIndex = param1;
         this.UpdateLabelPage();
      }
      
      public function get PageIndex() : int
      {
         return this.FPageIndex;
      }
      
      public function get TotalPage() : uint
      {
         return this.FTotalPage;
      }
      
      public function Init() : void
      {
         if(this.FInitialization)
         {
            return;
         }
         this.Initialization();
      }
      
      public function UpdateCopy() : void
      {
         this.UpdateTotalPage();
      }
      
      public function Update() : void
      {
         this.UpdateTotalPage();
         this.UpdateLabelPage();
         this.PageIndex = this.FPageIndex;
      }
      
      public function Reset() : void
      {
         this.FPageIndex = 0;
         this.Update();
      }
   }
}

