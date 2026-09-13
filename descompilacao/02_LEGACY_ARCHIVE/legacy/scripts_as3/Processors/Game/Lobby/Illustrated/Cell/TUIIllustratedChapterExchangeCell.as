package Processors.Game.Lobby.Illustrated.Cell
{
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedChapterExchange;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class TUIIllustratedChapterExchangeCell
   {
      
      private var _data:Object;
      
      private var _parent:TUIIllustratedChapterExchange;
      
      private var _mc:MovieClip;
      
      public function TUIIllustratedChapterExchangeCell(param1:TUIIllustratedChapterExchange, param2:MovieClip)
      {
         super();
         this._parent = param1;
         this._mc = param2;
         this._mc.addEventListener(MouseEvent.CLICK,this.OnSelectedItem);
      }
      
      public function UpdateUI(param1:Object) : void
      {
         this._data = param1;
         this._mc["TF_Name"].text = this._data ? this._data.Inventory.Name : "";
         this._mc["TF_Desc"].text = this._data ? TIllustratedModel.TextFormat(70470005,this._data.Resolve) : "";
         if(this._data)
         {
            this._mc.gotoAndStop(TIllustratedModel.Selecteds.indexOf(TIllustratedModel.MergeEquipID(this._data.Inventory)) == -1 ? 1 : 2);
         }
         else
         {
            this._mc.gotoAndStop(1);
         }
      }
      
      public function OnSelectedItem(param1:MouseEvent) : void
      {
         if(this._data == null)
         {
            return;
         }
         TIllustratedModel.ChangeSelecteds(TIllustratedModel.MergeEquipID(this._data.Inventory));
         this._parent.UpdateItems();
      }
      
      public function get selected() : Boolean
      {
         return TIllustratedModel.Selecteds.indexOf(TIllustratedModel.MergeEquipID(this._data.Inventory)) != -1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
   }
}

