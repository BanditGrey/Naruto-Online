package Processors.Game.Lobby.Illustrated.Cell
{
   import Logics.DatebaseVO.VO.TArchive;
   import Processors.Game.Lobby.Illustrated.TIllustratedModel;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class TUIIllustratedSuitCell
   {
      
      private var _data:TArchive;
      
      private var _mc:Sprite;
      
      private var _showTip:Function;
      
      private var _hideTip:Function;
      
      public function TUIIllustratedSuitCell(param1:Sprite, param2:Function, param3:Function)
      {
         super();
         this._mc = param1;
         this._mc.visible = false;
         var _loc4_:int = 1;
         while(_loc4_ <= 6)
         {
            _loc4_++;
         }
         this._showTip = param2;
         this._hideTip = param3;
      }
      
      public function set Data(param1:TArchive) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         this._data = param1;
         this._mc.visible = this._data != null;
         if(this._mc.visible)
         {
            _loc2_ = TIllustratedModel.ActivationData(this._data);
            this._mc["TF_Name"].text = this._data.Name;
            _loc3_ = 1;
            while(_loc3_ <= 6)
            {
               this._mc["MC_Equip_" + _loc3_].alpha = _loc2_.indexOf(_loc3_) != -1 ? 1 : 0;
               _loc3_++;
            }
            this._mc["TF_AddAttribute"].text = TIllustratedModel.AttributeFormat(this._data.AddAttributeVector[0][0],this._data.AddAttributeVector[0][1]);
            this._mc["TF_AddAttribute"].textColor = _loc2_.length >= 6 ? 16777215 : 10066329;
            this._mc["MC_BG"].gotoAndStop(_loc2_.length >= 6 ? 2 : 1);
         }
      }
      
      private function OnEquipOver(param1:Event) : void
      {
         if(this._showTip != null)
         {
            this._showTip("123");
         }
      }
      
      private function OnEquipOut(param1:Event) : void
      {
         if(this._hideTip != null)
         {
            this._hideTip();
         }
      }
   }
}

